import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';

class OverviewService {
  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;

  Map<DogSports, List<(Exercises, int)>> getHistoryOfLastFourWeeks(int dogId)
  {
    Map<DogSports, List<(Exercises, int)>> exerciseCounter = {};
    var dogResult = dogRepository.getDog(dogId);
    if(dogResult.isError()){
      return exerciseCounter;
    }

    var dog = dogResult.tryGetSuccess();

    var dateTimeFourWeeksAgo = DateTime.now().subtract(const Duration(days: 28));
    var lastFourWeeksResult = diaryEntryRepository.getAllEntriesByDogDate(dogId, dateTimeFourWeeksAgo, DateTime.now());

    if(lastFourWeeksResult.isError()){
      return exerciseCounter;
    }

    var lastFourWeeks = lastFourWeeksResult.tryGetSuccess();

    for(var sport in dog!.sports.keys){
      var lastFourWeeksBySport = lastFourWeeks!.where((x) => x.sport!.key == sport)
      .expand((x) => x.exerciseRating!)
      .toList();

      //count all exercises with rating > 0 and add it to counter. If exercies occur more than once int is increased by one
      var counter = lastFourWeeksBySport
      .where((rating) => rating.rating > 0
          && rating.exercise != Exercises.motivation
          && rating.exercise != Exercises.excitement
          && rating.exercise != Exercises.concentration
          && rating.exercise != Exercises.heelParking
          && rating.exercise != Exercises.heelSpeedNormal
          && rating.exercise != Exercises.heelAngle
          && rating.exercise != Exercises.heelSpeedSlow
          && rating.exercise != Exercises.heelSpeedFast
          && rating.exercise != Exercises.retrieveKeepCalm
          && rating.exercise != Exercises.retrieveFastPickUp
          && rating.exercise != Exercises.retrieveSpeed
          && rating.exercise != Exercises.retrieveDelivery
      )
      .groupBy((rating) => rating.exercise)
      .map((grouping) => (grouping.key, grouping.length))
      .orderByDescending((item) => item.$2)
      .toList();

      exerciseCounter[sport] = counter;
    }

    return exerciseCounter;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<OverviewService>(() => OverviewService());
  }

  static OverviewService get overviewService {
    return ServiceProvider.locator<OverviewService>();
  }
}