import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/overview_service.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/history_count.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:flutter/material.dart';

class OverviewViewModel extends ChangeNotifier {
  final DogRepository _repository = DogRepository.dogRepository;
  final OverviewService _overviewService = OverviewService.overviewService;

  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;
  Map<DogSports, List<HistoryCount>> _history = {};

  List<Widget> legend = [];

  void init() {
    loadDogs();
  }

  void loadDogs() {
    var dogsResult = _repository.getAllDogs();

    if(dogsResult.isSuccess()) {
      _dogs = dogsResult.tryGetSuccess() ?? List.empty();
      notifyListeners();
    }
  }

  List<HistoryCount?> getHistory(int dogId) {
    _history = _overviewService.getHistoryOfLastFourWeeks(dogId);

    List<HistoryCount?> mergedExerciseCounts = [];

    _history.forEach((dogSport, exercises) {
      for (var exerciseCount in exercises) {
        var item = mergedExerciseCounts.firstWhere((x) => x!.exercise == exerciseCount.exercise, orElse: () => null);
        if(item == null) {
          mergedExerciseCounts.add(exerciseCount);
        }
        else{
          item.increaseCount(exerciseCount.count);
        }
      }
    });

    return mergedExerciseCounts;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<OverviewViewModel>(() => OverviewViewModel());
  }

  static OverviewViewModel get overviewViewModel {
    return ServiceProvider.locator<OverviewViewModel>();
  }
}