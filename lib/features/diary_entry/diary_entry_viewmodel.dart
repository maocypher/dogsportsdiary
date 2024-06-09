import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/dog_sports_service.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class DiaryEntryViewModel extends ChangeNotifier {
  final DogRepository dogRepository;
  final DiaryEntryRepository diaryEntryRepository;
  final DogSportsService dogSportsService;

  DiaryEntry? _entry;
  String? get date => intl.DateFormat('yyyy-MM-dd').format(_entry?.date ?? DateTime.now());

  Dog? _selectedDog;
  Dog? get selectedDog => _selectedDog;

  List<Dog>? _dogList;
  List<Dog>? get dogList => _dogList;

  DogSports? _selectedSport;
  DogSports? get selectedSport => _selectedSport;

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
      loadSport(_selectedDog!.sports.keys.first);

      notifyListeners();
    }
  }

  loadSport(DogSports? sport) {
    if(sport != null) {
      _selectedSport = sport;
      loadSportTemplate(_selectedSport!);

      notifyListeners();
    }
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