import 'dart:async';
import 'dart:io';

import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/string_extensions.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class DogViewModel extends ChangeNotifier {
  final DogRepository repository = DogRepository.dogRepository;
  final Toast toast = Toast.toast;

  Dog? _dog;
  Dog? get dog => _dog;

  File? _imageFile;
  File? get imageFile => _imageFile;

  String? get dateOfBirth => intl.DateFormat('yyyy-MM-dd').format(_dog?.dateOfBirth ?? DateTime.now());

  Map<DogSports, List<DogSportsClasses>> get sportClasses => Sports.sportsClasses;
  List<DogSports> get sportList => Sports.sportsClasses.keys.toList();

  final selectedSports = ValueNotifier<List<DogSports>>([]);
  final StreamController<List<DogSports>> _selectedDogSportsStreamController = StreamController<List<DogSports>>();
  Stream<List<DogSports>> get selectedDogSportsStream => _selectedDogSportsStreamController.stream;

  Future<void> initAsync(String? idStr) async {
    if(idStr != null) {
      int? id = int.tryParse(idStr);
      if(id != null) {
        await loadDogAsync(id);
      }
    }
    else{
      _dog = Dog(
          name: '',
          dateOfBirth: DateTime.now(),
          sports: {},
          weight: Constants.initWeight
      );
    }
  }

  Future<void> loadDogAsync(int id) async {
    var dogResult = repository.getDog(id);

    if(dogResult.isSuccess()){
      _dog = dogResult.tryGetSuccess();
      if(_dog!.imagePath != null) {
        _imageFile = File(_dog!.imagePath!);
      }

      selectedSports.value = _dog!.sports.keys.toList();
      notifyListeners();
    }
    else{
      toast.showToast(msg: "Dog not found");
    }
  }

  Future<void> pickImageAsync() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File? croppedImage = await cropImageAsync(pickedFile);
      if (croppedImage != null) {
        _imageFile = croppedImage;
        _dog?.imagePath = _imageFile!.path;
        notifyListeners();
      }
    }
  }

  Future<File?> cropImageAsync(XFile imageFile) async {
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
    double weight = double.tryParse(weightString.fixInterpunctuation()) ?? Constants.initWeight;
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

  selectSports(DogSports? sport) {
    final multiValue = selectedSports.value;
    final isAlreadySelected = multiValue.contains(sport);
    
    if(isAlreadySelected){
      selectedSports.value = ([...multiValue]..remove(sport));
      _dog?.sports.remove(sport);
    }
    else{
      selectedSports.value = [...multiValue, sport!];
      _dog?.sports[sport] = sportClasses[sport]!.first;
    }

    notifyListeners();
  }

  removeSports(DogSports sport) {
    _dog?.sports.remove(sport);
  }

  updateSports(Map<DogSports, DogSportsClasses> sports) {
    _dog = _dog?.copyWith(sports: sports);
    notifyListeners();
  }

  deleteDogAsync() async {
    if(_dog != null) {
      await repository.deleteDogAsync(_dog!.id!);
    }
  }

  saveDogAsync() async {
    if(_dog != null) {
      await repository.saveDogAsync(_dog!);
    }
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DogViewModel>(() => DogViewModel());
  }

  static DogViewModel get dogViewModel {
    return ServiceProvider.locator<DogViewModel>();
  }
}