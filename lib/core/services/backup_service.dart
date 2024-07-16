import 'dart:io';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:file_picker/file_picker.dart';

class BackupService{

  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository = DiaryEntryRepository.diaryEntryRepository;

  Future<void> backup() async {
    var dogs = await dogRepository.getAllDogs();
    var diaryEntries = await diaryEntryRepository.getAllEntiresAsync();

    var dogsJson = dogs.map((e) => e.toJson()).toList();
    var diaryEntriesJson = diaryEntries.map((e) => e.toJson()).toList();

    var backupJson = {
      Constants.dogs: dogsJson,
      Constants.diary: diaryEntriesJson
    };

    var backupJsonString = backupJson.toString();

    String? folderPath = await FilePicker.platform.getDirectoryPath();

    if (folderPath != null) {
      File file = File('$folderPath/dog-sports-diary-backup.json');
      await file.writeAsString(backupJsonString, flush: true);
    }
  }

  Future<bool> restore() async {
    return true;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<BackupService>(() => BackupService());
  }

  static BackupService get backupService {
    return ServiceProvider.locator<BackupService>();
  }
}