import 'dart:async';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/dog_sports_service.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class DiaryEntryViewModel extends ChangeNotifier {
  final DogRepository dogRepository;
  final DiaryEntryRepository diaryEntryRepository;
  final DogSportsService dogSportsService;

  DiaryEntry? _entry;
  DiaryEntry? get entry => _entry;

  String? get date => intl.DateFormat('yyyy-MM-dd').format(_entry?.date ?? DateTime.now());

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

  DiaryEntryViewModel({
    required this.dogRepository,
    required this.diaryEntryRepository,
    required this.dogSportsService,
    int? entryId
  }){
    if(entryId != null) {
      loadEntry(entryId);
    }
    else{
      _entry = DiaryEntry(
          id: 0,
          date: DateTime.now(),
      );
    }

    loadDogs();
  }

  Future<void> loadEntry(int id) async {
    var dbEntry = await diaryEntryRepository.getEntry(id);

    if(dbEntry != null) {
      _entry = dbEntry;
      notifyListeners();
    }
  }

  Future<void> loadDogs() async {
    _dogList = await dogRepository.getAllDogs();

    if(_dogList != null && _dogList!.isNotEmpty) {
      await loadDog(_dogList!.first.id!);
    }

    notifyListeners();
  }

  Future<void> loadDog(int id) async {
    var dbDog = await dogRepository.getDog(id);

    if(dbDog != null) {
      _selectedDog = dbDog;
      _entry = _entry?.copyWith(dogName: _selectedDog!.name);

      _selectedDogSports = DogSportsTupleJsonExtension.toList(_selectedDog!.sports);

      if(_selectedDogSports.isNotEmpty) {
        loadSport(_selectedDogSports.first);
      }

      notifyListeners();
    }
  }

  loadSport(Tuple<DogSports, DogSportsClasses> sport) {
    _selectedSport = sport;

    var exercise = sportExercises.entries.where((e) => e.key == sport).first.value;
    _selectedExercises = exercise.map((e) => Tuple(e, Constants.initRating)).toList();

    _entry = _entry?.copyWith(sport: _selectedSport, exerciseRating: _selectedExercises);

    notifyListeners();
  }

  updateDate(DateTime date) {
    _entry = _entry?.copyWith(date: date);
    notifyListeners();
  }

  updateRating(Exercises exercise, double rating) {
    var index = _selectedExercises.indexWhere((e) => e.key == exercise);

    if(index != -1) {
      _selectedExercises[index] = Tuple(exercise, rating);
      _entry = _entry?.copyWith(exerciseRating: _selectedExercises);
    }

    notifyListeners();
  }

  updateTemperature(String temperature) {
    var temp = double.tryParse(temperature);
    _entry = _entry?.copyWith(temperature: temp);
    notifyListeners();
  }

  updateTrainingDurationInMin(String trainingDurationInMin) {
    var duration = int.tryParse(trainingDurationInMin);
    _entry = _entry?.copyWith(trainingDurationInMin: duration);
    notifyListeners();
  }

  updateWarmUpDurationInMin(String warmUpDurationInMin) {
    var duration = int.tryParse(warmUpDurationInMin);
    _entry = _entry?.copyWith(warmUpDurationInMin: duration);
    notifyListeners();
  }

  updateCoolDownDurationInMin(String coolDownDurationInMin) {
    var duration = int.tryParse(coolDownDurationInMin);
    _entry = _entry?.copyWith(coolDownDurationInMin: duration);
    notifyListeners();
  }

  updateTrainingGoal(String trainingGoal) {
    _entry = _entry?.copyWith(trainingGoal: trainingGoal);
    notifyListeners();
  }

  updateHighlight(String highlight) {
    _entry = _entry?.copyWith(highlight: highlight);
    notifyListeners();
  }

  updateDistractions(String distractions) {
    _entry = _entry?.copyWith(distractions: distractions);
    notifyListeners();
  }

  updateNotes(String notes) {
    _entry = _entry?.copyWith(notes: notes);
    notifyListeners();
  }

  deleteEntry() async {
    if(_entry != null) {
      //await diaryEntryRepository.deleteEntry(_entry!.);
    }
  }

  saveEntry() async {
    if(_entry != null) {
      //await diaryEntryRepository.saveEntry(_entry!);
    }
  }

  static inject() {
    // injecting the viewmodel
    final dogRepository = ServiceProvider.locator<DogRepository>();
    final diaryEntryRepository = ServiceProvider.locator<DiaryEntryRepository>();
    final dogSportsService = ServiceProvider.locator<DogSportsService>();

    ServiceProvider.locator.registerFactoryParam<DiaryEntryViewModel, int?, void>(
            (x, _) => DiaryEntryViewModel(
                dogRepository: dogRepository,
                diaryEntryRepository: diaryEntryRepository,
                dogSportsService: dogSportsService,
                entryId: x
            ));
  }

  static DiaryEntryViewModel get dogViewModel {
    return ServiceProvider.locator<DiaryEntryViewModel>();
  }
}