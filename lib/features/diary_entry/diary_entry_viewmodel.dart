import 'dart:async';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/string_extensions.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryEntryViewModel extends ChangeNotifier {
  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository = DiaryEntryRepository.diaryEntryRepository;

  DiaryEntry? _diaryEntry;
  DiaryEntry? get entry => _diaryEntry;

  String? get date => DateFormat('yyyy-MM-dd').format(_diaryEntry?.date ?? DateTime.now());

  List<Dog>? _dogList;
  List<Dog>? get dogList => _dogList;

  Dog? _selectedDog;
  Dog? get selectedDog => _selectedDog;

  List<Tuple<DogSports, DogSportsClasses>> _selectedDogSports = [];
  List<Tuple<DogSports, DogSportsClasses>> get selectedDogSports => _selectedDogSports;

  Tuple<DogSports, DogSportsClasses>? _selectedSport;
  Tuple<DogSports, DogSportsClasses>? get selectedSport => _selectedSport;

  Map<Tuple<DogSports, DogSportsClasses>, List<Exercises>> get sportExercises => Sports.sportsExercises;
  List<Tuple<Exercises, double>> _selectedExercises = [];
  List<Tuple<Exercises, double>> get selectedExercises => _selectedExercises;

  final StreamController<List<Exercises>> _selectedDogSportsExercisesStreamController = StreamController<List<Exercises>>();
  Stream<List<Exercises>> get selectedDogSportsExercisesStream => _selectedDogSportsExercisesStreamController.stream;

  Future<DiaryEntryViewModel> init(String? idStr) async {
    if(idStr != null) {
      int? id = int.tryParse(idStr);
      if(id != null) {
        await loadEntry(id);
      }
    }
    else{
      _diaryEntry = DiaryEntry(
        date: DateTime.now(),
        temperature: Constants.initTemperature,
        trainingDurationInMin: Constants.initMinutes,
        warmUpDurationInMin: Constants.initMinutes,
        coolDownDurationInMin: Constants.initMinutes
      );
    }

    await loadDogs();

    return this;
  }

  Future<void> loadEntry(int id) async {
    var dbEntry = await diaryEntryRepository.getEntryAsync(id);

    if(dbEntry != null) {
      _diaryEntry = dbEntry;

      if(dbEntry.dogId != null) {
        await loadDog(dbEntry.dogId!, dbEntry);
      }

      notifyListeners();
    }
  }

  Future<void> loadDogs() async {
    _dogList = await dogRepository.getAllDogs();

    if(_dogList != null
        && _dogList!.isNotEmpty
        && _selectedDog == null) {
      await loadDog(_dogList!.first.id!, null);
    }

    notifyListeners();
  }

  Future<void> loadDog(int id, DiaryEntry? diaryEntry) async {
    var dbDog = await dogRepository.getDog(id);

    if(dbDog != null) {
      _selectedDog = dbDog;
      _selectedDogSports = DogSportsTupleJsonExtension.toList(_selectedDog!.sports);

      if(diaryEntry == null) {
        _diaryEntry = _diaryEntry?.copyWith(dogId: _selectedDog!.id!);

        if(_selectedDogSports.isNotEmpty) {
          loadSport(_selectedDogSports.first);
        }
      }
      else{
        if(!_selectedDogSports.contains(diaryEntry.sport)){
          _selectedDogSports.add(diaryEntry.sport!);
        }

        _selectedSport = diaryEntry.sport;
        _selectedExercises = diaryEntry.exerciseRating!;
      }

      notifyListeners();
    }
  }

  loadSport(Tuple<DogSports, DogSportsClasses> sport) {
    _selectedSport = sport;

    var exercise = sportExercises.entries.where((e) => e.key == sport).first.value;
    _selectedExercises = exercise.map((e) => Tuple(e, Constants.initRating)).toList();

    _diaryEntry = _diaryEntry?.copyWith(sport: _selectedSport, exerciseRating: _selectedExercises);

    notifyListeners();
  }

  updateDate(DateTime date) {
    _diaryEntry = _diaryEntry?.copyWith(date: date);
    notifyListeners();
  }

  updateRating(Exercises exercise, double rating) {
    var index = _selectedExercises.indexWhere((e) => e.key == exercise);

    if(index != -1) {
      var oldRating = _selectedExercises[index].value;
      if(oldRating == rating) {
        rating = Constants.initRating;
      }

      _selectedExercises[index] = Tuple(exercise, rating);
      _diaryEntry = _diaryEntry?.copyWith(exerciseRating: _selectedExercises);
    }
  }

  updateTemperature(String temperature) {
    var temp = double.tryParse(temperature.fixInterpunctuation());
    _diaryEntry = _diaryEntry?.copyWith(temperature: temp);
  }

  updateTrainingDurationInMin(String trainingDurationInMin) {
    var duration = int.tryParse(trainingDurationInMin);
    _diaryEntry = _diaryEntry?.copyWith(trainingDurationInMin: duration);
  }

  updateWarmUpDurationInMin(String warmUpDurationInMin) {
    var duration = int.tryParse(warmUpDurationInMin);
    _diaryEntry = _diaryEntry?.copyWith(warmUpDurationInMin: duration);
  }

  updateCoolDownDurationInMin(String coolDownDurationInMin) {
    var duration = int.tryParse(coolDownDurationInMin);
    _diaryEntry = _diaryEntry?.copyWith(coolDownDurationInMin: duration);
  }

  updateTrainingGoal(String trainingGoal) {
    _diaryEntry = _diaryEntry?.copyWith(trainingGoal: trainingGoal);
  }

  updateHighlight(String highlight) {
    _diaryEntry = _diaryEntry?.copyWith(highlight: highlight);
  }

  updateDistractions(String distractions) {
    _diaryEntry = _diaryEntry?.copyWith(distractions: distractions);
  }

  updateNotes(String notes) {
    _diaryEntry = _diaryEntry?.copyWith(notes: notes);
  }

  deleteEntry() async {
    if(_diaryEntry != null) {
      await diaryEntryRepository.deleteEntryAsync(_diaryEntry!.id!);
    }
  }

  saveEntry() async {
    if(_diaryEntry != null) {
      await diaryEntryRepository.saveEntryAsync(_diaryEntry!);
    }
  }

  static inject() {
    ServiceProvider.locator.registerFactory<DiaryEntryViewModel>(() => DiaryEntryViewModel());
  }

  static DiaryEntryViewModel get diaryEntryViewModel {
    return ServiceProvider.locator<DiaryEntryViewModel>();
  }
}