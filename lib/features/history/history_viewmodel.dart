import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/value_objects/history_count.dart';
import 'package:dog_sports_diary/domain/value_objects/sports.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  final DogRepository _repository = DogRepository.dogRepository;


  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;
  Map<DogSports, List<HistoryCount>> _history = {};

  List<Widget> legend = [];

  void init() {
    loadDogs();
  }

  void loadDogs() {
    var dogsResult = _repository.getAllDogs();

    if (dogsResult.isSuccess()) {
      _dogs = dogsResult.tryGetSuccess() ?? List.empty();
      notifyListeners();
    }
  }

  static inject() {
    ServiceProvider.locator.registerFactory<HistoryViewModel>(() => HistoryViewModel());
  }

  static HistoryViewModel get historyViewModel {
    return ServiceProvider.locator<HistoryViewModel>();
  }
}