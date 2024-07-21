import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter/widgets.dart';

class ShowDiaryEntryViewmodel extends ChangeNotifier {
  final DogRepository _dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository _diaryEntryRepository = DiaryEntryRepository.diaryEntryRepository;

  List<Dog> _dogs = List.empty();
  List<Dog> get dogs => _dogs;

  List<DiaryEntry> _diaryEntries = List.empty();
  List<DiaryEntry> get diaryEntries => _diaryEntries;

  Future<void> initAsync() async {
    await loadDogsAsync();
    await loadDiaryEntriesAsync();
  }

  Future<bool> hasAnyDogsAsync() async {
    return await _dogRepository.hasAnyDogAsync();
  }

  Future<void> loadDogsAsync() async {
    var dbDogs = await _dogRepository.getAllDogsAsync();
    _dogs = dbDogs;
    notifyListeners();
  }

  Future<void> loadDiaryEntriesAsync() async {
    var entriesResult = _diaryEntryRepository.getAllEntries();

    if(entriesResult.isSuccess()) {
      _diaryEntries = entriesResult.getOrDefault(List.empty());
      notifyListeners();
    }
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerLazySingleton<ShowDiaryEntryViewmodel>(() => ShowDiaryEntryViewmodel());
  }

  static ShowDiaryEntryViewmodel get showDiaryEntryViewModel {
    return ServiceProvider.locator<ShowDiaryEntryViewmodel>();
  }
}