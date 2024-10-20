import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';
import 'package:dog_sports_diary/domain/value_objects/history_entry.dart';

class HistoryService {
  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;

  List<HistoryEntry> getHistoryOfLastFourWeeks(int dogId, Exercises exercise)
  {
    List<HistoryEntry> historyEntries = [];
    var dogResult = dogRepository.getDog(dogId);
    if(dogResult.isError()){
      return historyEntries;
    }

    var dog = dogResult.tryGetSuccess();

    var dateTimeFourWeeksAgo = DateTime.now().subtract(const Duration(days: 28));
    var lastFourWeeksResult = diaryEntryRepository.getAllEntriesByDogDate(dogId, dateTimeFourWeeksAgo, DateTime.now());

    if(lastFourWeeksResult.isError()){
      return historyEntries;
    }

    var lastFourWeeks = lastFourWeeksResult.tryGetSuccess();

    for(var sport in dog!.sports.keys){
      var lastFourWeeksBySport = lastFourWeeks!.where((x) => x.sport!.key == sport && x.exerciseRating!.any((y) => y.exercise == exercise && y.rating > 0))
          .map((x) => HistoryEntry(rating: x.exerciseRating!.firstWhere((x) => x.exercise == exercise), date: x.date));

      historyEntries.addAll(lastFourWeeksBySport);
    }

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