import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter/material.dart';

class ShowDogsViewModel extends ChangeNotifier {
  final DogRepository _repository;
  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;

  ShowDogsViewModel(this._repository) {
    loadDogs();
  }

  Future<void> loadDogs() async {
    var dbDogs = await _repository.getAllDogs();
    _dogs = dbDogs;
    notifyListeners();
  }

  static inject() {
    // injecting the viewmodel
    final repository = ServiceProvider.locator<DogRepository>();
    ServiceProvider.locator.registerLazySingleton<ShowDogsViewModel>(() => ShowDogsViewModel(repository));
  }

  static ShowDogsViewModel get showDogsViewModel {
    return ServiceProvider.locator<ShowDogsViewModel>();
  }
}