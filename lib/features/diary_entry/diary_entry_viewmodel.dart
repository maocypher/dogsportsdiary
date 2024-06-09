import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/dog_sports_service.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class DiaryEntryViewModel extends ChangeNotifier {
  final DogRepository dogRepository;
  final DiaryEntryRepository diaryEntryRepository;
  final DogSportsService dogSportsService;

  DiaryEntry? _entry;
  String? get date => intl.DateFormat('yyyy-MM-dd').format(_entry?.date ?? DateTime.now());

  List<Dog>? _dogList;
  List<Dog>? get dogList => _dogList;

  Dog? _selectedDog;
  Dog? get selectedDog => _selectedDog;

  List<Tuple<DogSports, DogSportsClasses>> _selectedDogSports = [];
  List<Tuple<DogSports, DogSportsClasses>> get selectedDogSports => _selectedDogSports;

  Tuple<DogSports, DogSportsClasses>? _selectedSport;
  Tuple<DogSports, DogSportsClasses>? get selectedSport => _selectedSport;

  Map<String, dynamic>? sportsTemplate;
  Map<String, dynamic>? get template => sportsTemplate;

  DiaryEntryViewModel({
    required this.dogRepository,
    required this.diaryEntryRepository,
    required this.dogSportsService,
    String? entryKey
  }){
    if(entryKey != null) {
      loadEntry(entryKey);
    }
    else{
      _entry = DiaryEntry(
          id: 0,
          date: DateTime.now(),
      );
    }

    loadDogs();
  }

  Future<void> loadEntry(String entryKey) async {
    var dbEntry = await diaryEntryRepository.getEntry(entryKey);

    if(dbEntry != null) {
      _entry = dbEntry;
      notifyListeners();
    }
  }

  Future<void> loadDogs() async {
    _dogList = await dogRepository.getAllDogs();

    if(_dogList != null && _dogList!.isNotEmpty) {
      await loadDog(_dogList!.first.name);
    }

    notifyListeners();
  }

  Future<void> loadDog(String name) async {
    var dbDog = await dogRepository.getDog(name);

    if(dbDog != null) {
      _selectedDog = dbDog;
      _selectedDogSports = DogSportsJsonExtension.toListOfTuple(_selectedDog!.sports);

      if(_selectedDogSports.isNotEmpty) {
        loadSport(_selectedDogSports.first);
      }

      notifyListeners();
    }
  }

  loadSport(Tuple<DogSports, DogSportsClasses> sport) {
    _selectedSport = sport;
    //loadSportTemplate(_selectedSport!);

    notifyListeners();
  }

  loadSportTemplate(DogSports sport) async {
    //sportsTemplate = await dogSportsService.loadJsonFileForSports(sport);
  }

  updateDate(DateTime date) {
    _entry = _entry?.copyWith(date: date);
    notifyListeners();
  }

  deleteEntry() async {
    if(_entry != null) {
      //await diaryEntryRepository.deleteEntry();
    }
  }

  saveEntry() async {
    if(_entry != null) {
      //await diaryEntryRepository.saveDog(_dog!);
    }
  }

  static inject() {
    // injecting the viewmodel
    final dogRepository = ServiceProvider.locator<DogRepository>();
    final diaryEntryRepository = ServiceProvider.locator<DiaryEntryRepository>();
    final dogSportsService = ServiceProvider.locator<DogSportsService>();

    ServiceProvider.locator.registerFactoryParam<DiaryEntryViewModel, String?, void>(
            (x, _) => DiaryEntryViewModel(
                dogRepository: dogRepository,
                diaryEntryRepository: diaryEntryRepository,
                dogSportsService: dogSportsService,
                entryKey: x
            ));
  }

  static DiaryEntryViewModel get dogViewModel {
    return ServiceProvider.locator<DiaryEntryViewModel>();
  }
}