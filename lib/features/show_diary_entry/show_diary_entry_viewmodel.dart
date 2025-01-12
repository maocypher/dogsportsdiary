import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/widgets.dart';

class ShowDiaryEntryViewmodel extends ChangeNotifier {
  final DogRepository _dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository _diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;
  final Toast _toast = Toast.toast;

  List<Dog> _dogs = List.empty();
  List<Dog> get dogs => _dogs;

  List<DiaryEntry> _diaryEntries = List.empty();
  List<DiaryEntry> get diaryEntries => _diaryEntries;

  void init() {
    loadDogs();
    loadDiaryEntries();
  }

  bool hasAnyDogs() {
    var result = _dogRepository.hasAnyDogs();
    if (result.isSuccess()) {
      return result.tryGetSuccess() ?? false;
    } else {
      _toast.showToast(msg: "Something went wrong. Please try again later.");
      return false;
    }
  }

  void loadDogs() {
    var dogsResult = _dogRepository.getAllDogs();

    if (dogsResult.isSuccess()) {
      _dogs = dogsResult.tryGetSuccess() ?? List.empty();
      notifyListeners();
    }
  }

  void loadDiaryEntries() {
    var entriesResult = _diaryEntryRepository.getAllEntries();

    if (entriesResult.isSuccess()) {
      _diaryEntries = entriesResult.tryGetSuccess() ?? List.empty();
      notifyListeners();
    } else {
      _toast.showToast(msg: "Something went wrong. Please try again later.");
    }
  }

  List<DiaryEntry> loadTrainingGoals(int dogId) {
    var dogDiaryEntries = _diaryEntries.where((entry) => entry.dogId == dogId).toList();

    var trainingGoalsEntries = dogDiaryEntries.where((entry) =>
        entry.exerciseRating != null &&
        entry.exerciseRating!
            .any((rating) => rating.trainingGoals != null && rating.trainingGoals!.title.trim().isNotEmpty)).toList();

    var lastFiveTrainings = trainingGoalsEntries.take(5).toList();

    return lastFiveTrainings;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerLazySingleton<ShowDiaryEntryViewmodel>(
        () => ShowDiaryEntryViewmodel());
  }

  static ShowDiaryEntryViewmodel get showDiaryEntryViewModel {
    return ServiceProvider.locator<ShowDiaryEntryViewmodel>();
  }
}
