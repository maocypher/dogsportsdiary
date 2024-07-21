import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter/material.dart';

class ShowDogsViewModel extends ChangeNotifier {
  final DogRepository _repository = DogRepository.dogRepository;
  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;

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

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerLazySingleton<ShowDogsViewModel>(() => ShowDogsViewModel());
  }

  static ShowDogsViewModel get showDogsViewModel {
    return ServiceProvider.locator<ShowDogsViewModel>();
  }
}