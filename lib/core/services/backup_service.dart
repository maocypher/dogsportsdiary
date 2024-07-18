import 'dart:io';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/backup.dart';
import 'package:file_picker/file_picker.dart';

class BackupService {
  //internal-directory: /storage/emulated/0/Android/data/com.anni.dog_sports_diary/files/downloads/
  static const String fileName = 'dgSptDryBak.json';

  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;

  Future<BackupResult> backup() async {
    try {
      var dogs = await dogRepository.getAllDogs();
      var diaryEntries = await diaryEntryRepository.getAllEntiresAsync();

      var date = DateTime.now();
      var backup = Backup(dogs: dogs, diaryEntries: diaryEntries, date: date);
      var backupJsonString = backup.toJsonString();

      var directory = await FilePicker.platform.getDirectoryPath();

      if (directory == null) {
        return BackupResult.cancelled;
      }

      File file = File(
          '$directory/${date.toIso8601String().substring(0, 10)}_$fileName');
      if (!file.existsSync()) {
        file.createSync();
      }

      await file.writeAsString(backupJsonString, flush: true);

      return BackupResult.success;
    } catch (e) {
      return BackupResult.failure;
    }
  }

  Future<BackupResult> restore() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);

      if (result == null) {
        return BackupResult.cancelled;
      }

      var filePath = result.files.first.path;
      if(filePath == null) {
        return BackupResult.failure;
      }

      File file = File(filePath);
      file.openSync(mode: FileMode.read);
      var backupJsonString = await file.readAsString();
      var backup = Backup.fromJsonString(backupJsonString);

      return BackupResult.success;
    } catch (e) {
      return BackupResult.failure;
    }
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<BackupService>(() => BackupService());
  }

  static BackupService get backupService {
    return ServiceProvider.locator<BackupService>();
  }
}
