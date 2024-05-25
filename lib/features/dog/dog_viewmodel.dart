import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter/material.dart';

class DogViewModel extends ChangeNotifier {
  final DogRepository _repository;
  late Dog? _dog;

  Dog? get dog => _dog;

  DogViewModel(this._repository);

  Future<void> loadDog(String name) async {
    var dbDog = await _repository.getDog(name);

    _dog = dbDog ?? Dog(name: name, id: 0, dateOfBirth: DateTime.now(), sports: []);
    notifyListeners();
  }

  updateWeight(double weight) {
    _dog = _dog?.copyWith(weight: weight);
    notifyListeners();
  }

  updateImageAsBase64(String imageAsBase64) {
    _dog = _dog?.copyWith(imageAsBase64: imageAsBase64);
    notifyListeners();
  }

  updateName(String name) {
    _dog = _dog?.copyWith(name: name);
    notifyListeners();
  }

  updateDateOfBirth(DateTime dateOfBirth) {
    _dog = _dog?.copyWith(dateOfBirth: dateOfBirth);
    notifyListeners();
  }

  updateSports(List<String> sports) {
    _dog = _dog?.copyWith(sports: sports);
    notifyListeners();
  }

  saveDog() async {
    if(_dog != null){
      await _repository.saveDog(_dog!);
    }
  }

  static inject() {
    // injecting the viewmodel
    final repository = ServiceProvider.locator<DogRepository>();
    ServiceProvider.locator.registerFactory<DogViewModel>(() => DogViewModel(repository));
  }

  static DogViewModel get dogViewModel {
    return ServiceProvider.locator<DogViewModel>();
  }
}