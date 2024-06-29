import 'dart:async';
import 'dart:io';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class DogViewModel extends ChangeNotifier {
  final DogRepository repository;

  Dog? _dog;
  Dog? get dog => _dog;

  File? _imageFile;
  File? get imageFile => _imageFile;

  String? get dateOfBirth => intl.DateFormat('yyyy-MM-dd').format(_dog?.dateOfBirth ?? DateTime.now());

  Map<DogSports, List<DogSportsClasses>> get sportClasses => Sports.sportsClasses;
  List<DogSports> get sportList => Sports.sportsClasses.keys.toList();

  List<DogSports> _selectedSports = [];
  List<DogSports> get selectedSports => _selectedSports;
  set selectedSports(List<DogSports> value) {
    _selectedSports = value;
    notifyListeners();
  }
  StreamController<List<DogSports>> _selectedDogSportsStreamController = StreamController<List<DogSports>>();
  Stream<List<DogSports>> get selectedDogSportsStream => _selectedDogSportsStreamController.stream;

  DogViewModel({
    required this.repository,
    String? idStr
  }){
    if(idStr != null) {
      int? id = int.tryParse(idStr);
      if(id != null){
        loadDog(id);
      }
    }
    else{
      _dog = Dog(name: '', dateOfBirth: DateTime.now(), sports: {});
    }
  }

  Future<void> loadDog(int id) async {
    var dbDog = await repository.getDog(id);

    if(dbDog != null) {
      _dog = dbDog;
      if(_dog!.imagePath != null) {
        _imageFile = File(_dog!.imagePath!);
      }
      _selectedSports = _dog!.sports.keys.toList();
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File? croppedImage = await cropImage(pickedFile);
      if (croppedImage != null) {
        _imageFile = croppedImage;
        _dog?.imagePath = _imageFile!.path;
        notifyListeners();
      }
    }
  }

  Future<File?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Select avatar',
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        // IOSUiSettings(
        //   title: 'Cropper',
        // ),
        // WebUiSettings(
        //   context: context,
        // ),
      ],
    );

    if (croppedFile != null) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String croppedPath = '${appDocDir.path}/${imageFile.name}_cropped.jpg';

      var file = File(croppedFile.path);
      var targetFile = await file.copy(croppedPath);

      return targetFile;
    }

    return null;
  }

  updateWeight(String weightString) {
    double weight = double.tryParse(weightString) ?? 0.0;
    _dog = _dog?.copyWith(weight: weight);
  }

  updateName(String name) {
    _dog = _dog?.copyWith(name: name);
  }

  updateDateOfBirth(DateTime dateOfBirth) {
    _dog = _dog?.copyWith(dateOfBirth: dateOfBirth);
    notifyListeners();
  }

  addSports(DogSports sport, DogSportsClasses sportClass) {
    _dog?.sports[sport] = sportClass;
    notifyListeners();
  }

  selectSports(List<DogSports> sports) {
    selectedSports = sports;

    selectedSports.forEach((sport){
      _dog?.sports[sport] = sportClasses[sport]!.first;
    });

    notifyListeners();
  }

  removeSports(DogSports sport) {
    _dog?.sports.remove(sport);
    notifyListeners();
  }

  updateSports(Map<DogSports, DogSportsClasses> sports) {
    _dog = _dog?.copyWith(sports: sports);
    notifyListeners();
  }

  deleteDog() async {
    if(_dog != null) {
      await repository.deleteDog(_dog!.id!);
    }
  }

  saveDog() async {
    if(_dog != null) {
      await repository.saveDog(_dog!);
    }
  }

  static inject() {
    // injecting the viewmodel
    final repository = ServiceProvider.locator<DogRepository>();
    //ServiceProvider.locator.registerFactory<DogViewModel>(() => DogViewModel(repository: repository));
    ServiceProvider.locator.registerFactoryParam<DogViewModel, String?, void>(
            (x, _) => DogViewModel(repository: repository, idStr: x));
  }

  static DogViewModel get dogViewModel {
    return ServiceProvider.locator<DogViewModel>();
  }
}