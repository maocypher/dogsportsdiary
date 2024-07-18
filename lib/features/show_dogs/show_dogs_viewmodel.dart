import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter/material.dart';

class ShowDogsViewModel extends ChangeNotifier {
  final DogRepository _repository = DogRepository.dogRepository;
  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;

  Future<void> initAsync() async {
    await loadDogsAsync();
  }

  Future<void> loadDogsAsync() async {
    var dbDogs = await _repository.getAllDogsAsync();
    _dogs = dbDogs;
    notifyListeners();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerLazySingleton<ShowDogsViewModel>(() => ShowDogsViewModel());
  }

  static ShowDogsViewModel get showDogsViewModel {
    return ServiceProvider.locator<ShowDogsViewModel>();
  }
}