import 'dart:io';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DogViewModel extends ChangeNotifier {
  final DogRepository _repository;

  Dog _dog = Dog(name: '', id: 0, dateOfBirth: DateTime.now(), sports: []);
  Dog get dog => _dog;

  File? _imageFile;
  File? get imageFile => _imageFile;

  String? get dateOfBirth => DateFormat('yyyy-MM-dd').format(_dog.dateOfBirth);

  DogViewModel(this._repository);

  Future<void> loadDog(String name) async {
    var dbDog = await _repository.getDog(name);

    if(dbDog != null) {
      _dog = dbDog;
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }

    notifyListeners();
  }

  updateWeight(String weightString) {
    double weight = double.tryParse(weightString) ?? 0.0;
    _dog = _dog.copyWith(weight: weight);
    notifyListeners();
  }

  updateImageAsBase64(String imageAsBase64) {
    _dog = _dog.copyWith(imageAsBase64: imageAsBase64);
    notifyListeners();
  }

  updateName(String name) {
    _dog = _dog.copyWith(name: name);
    notifyListeners();
  }

  updateDateOfBirth(DateTime dateOfBirth) {
    _dog = _dog.copyWith(dateOfBirth: dateOfBirth);
    notifyListeners();
  }

  addSports(Sports sport) {
    _dog.sports.add(sport);
    notifyListeners();
  }

  removeSports(Sports sport) {
    _dog.sports.remove(sport);
    notifyListeners();
  }

  saveDog() async {
    await _repository.saveDog(_dog);
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