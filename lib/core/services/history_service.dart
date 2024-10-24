import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';
import 'package:dog_sports_diary/domain/value_objects/history_entry.dart';

class HistoryService {
  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;

  List<HistoryEntry> getHistoryOfExercise(int dogId, Exercises exercise)
  {
    List<HistoryEntry> historyEntries = [];
    var dogResult = dogRepository.getDog(dogId);
    if(dogResult.isError()){
      return historyEntries;
    }

    var lastTwentyTrainingsResult = diaryEntryRepository.getAllEntriesByDogExercise(dogId, exercise, 20);

    if(lastTwentyTrainingsResult.isError()){
      return historyEntries;
    }

    var lastTwentyTrainings = lastTwentyTrainingsResult.tryGetSuccess();

    historyEntries = lastTwentyTrainings!.map((x) => HistoryEntry(rating: x.exerciseRating!.firstWhere((x) => x.exercise == exercise), date: x.date)).toList();
    historyEntries.sort((HistoryEntry a, HistoryEntry b) => a.date.compareTo(b.date));

    return historyEntries;
  }

  List<HistoryEntry> getHistoryOfExerciseDate(int dogId, Exercises exercise, DateTime startDate, DateTime endDate)
  {
    List<HistoryEntry> historyEntries = [];
    var dogResult = dogRepository.getDog(dogId);
    if(dogResult.isError()){
      return historyEntries;
    }

    var lastTrainingsResult = diaryEntryRepository.getAllEntriesByDogExerciseDate(dogId, exercise, startDate, endDate);

    if(lastTrainingsResult.isError()){
      return historyEntries;
    }

    var lastTrainings = lastTrainingsResult.tryGetSuccess();

    historyEntries = lastTrainings!.map((x) => HistoryEntry(rating: x.exerciseRating!.firstWhere((x) => x.exercise == exercise), date: x.date)).toList();
    historyEntries.sort((HistoryEntry a, HistoryEntry b) => a.date.compareTo(b.date));

    return historyEntries;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<HistoryService>(() => HistoryService());
  }

  static HistoryService get historyService {
    return ServiceProvider.locator<HistoryService>();
  }
}