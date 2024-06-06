import 'package:dog_sports_diary/core/di/serivce_provider.dart';
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

  DiaryEntry? _entry;
  Dog? _selectedDog;
  List<Dog>? _dogList;
  List<Dog>? get dogList => _dogList;
  List<Sports> get sportList => _selectedDog?.sports ?? Sports.values.toList();
  String? get date => intl.DateFormat('yyyy-MM-dd').format(_entry?.date ?? DateTime.now());

  DiaryEntryViewModel({
    required this.dogRepository,
    required this.diaryEntryRepository,
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
    if(_dogList != null && _dogList!.isNotEmpty) {
      loadDog(_dogList!.first.name);
    }
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
    notifyListeners();
  }

  Future<void> loadDog(String name) async {
    var dbDog = await dogRepository.getDog(name);

    if(dbDog != null) {
      _selectedDog = dbDog;
      notifyListeners();
    }
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

    ServiceProvider.locator.registerFactoryParam<DiaryEntryViewModel, String?, void>(
            (x, _) => DiaryEntryViewModel(dogRepository: dogRepository, diaryEntryRepository: diaryEntryRepository, entryKey: x));
  }

  static DiaryEntryViewModel get dogViewModel {
    return ServiceProvider.locator<DiaryEntryViewModel>();
  }
}