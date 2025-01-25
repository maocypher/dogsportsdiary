import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/value_objects/rating.dart';
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

  bool detailedView = false;

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

  void toggleDetailedView(){
    detailedView = !detailedView;
    loadDiaryEntries();
    notifyListeners();
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

    return dogDiaryEntries.where((entry) =>
        entry.exerciseRating != null &&
        entry.exerciseRating!
            .any((rating) => rating.trainingGoals != null && rating.trainingGoals!.title.trim().isNotEmpty)).toList();
  }

  void markTrainingGoalAsReached(int diaryEntryId, Rating rating){
    var diaryEntryResult = _diaryEntryRepository.getEntry(diaryEntryId);

    if(diaryEntryResult.isSuccess()){
      var diaryEntry = diaryEntryResult.tryGetSuccess();
      if(diaryEntry == null){
        _toast.showToast(msg: "Diary entry does not exist");
      }
      else{
        var exercises = diaryEntry.exerciseRating;
        if(exercises == null || exercises.isEmpty){
          return;
        }

        var index = exercises.indexWhere((e) => e.exercise == rating.exercise);
        if(index != -1) {
          var reachedGoal = rating.trainingGoals!.markAsReached();

          var currentRating = exercises[index];
          currentRating = currentRating.copyWith(trainingGoals: reachedGoal);

          exercises[index] = currentRating;

          diaryEntry = diaryEntry.copyWith(exerciseRating: exercises);
          _diaryEntryRepository.saveEntryAsync(diaryEntry);

          loadDiaryEntries();
        }
      }
    }
    else{
      _toast.showToast(msg: "Error marking training goal as reached");
    }
  }

  void markTrainingGoalAsUnreached(int diaryEntryId, Rating rating){
    var diaryEntryResult = _diaryEntryRepository.getEntry(diaryEntryId);

    if(diaryEntryResult.isSuccess()){
      var diaryEntry = diaryEntryResult.tryGetSuccess();
      if(diaryEntry == null){
        _toast.showToast(msg: "Diary entry does not exist");
      }
      else{
        var exercises = diaryEntry.exerciseRating;
        if(exercises == null || exercises.isEmpty){
          return;
        }

        var index = exercises.indexWhere((e) => e.exercise == rating.exercise);
        if(index != -1) {
          var reachedGoal = rating.trainingGoals!.markAsUnreached();

          var currentRating = exercises[index];
          currentRating = currentRating.copyWith(trainingGoals: reachedGoal);

          exercises[index] = currentRating;

          diaryEntry = diaryEntry.copyWith(exerciseRating: exercises);
          _diaryEntryRepository.saveEntryAsync(diaryEntry);

          loadDiaryEntries();
        }
      }
    }
    else{
      _toast.showToast(msg: "Error marking training goal as reached");
    }
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
