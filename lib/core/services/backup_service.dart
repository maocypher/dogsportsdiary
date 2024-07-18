import 'dart:io';

import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/backup.dart';
import 'package:path_provider/path_provider.dart';

class BackupService {
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

      // /storage/emulated/0/Android/data/com.anni.dog_sports_diary/files/downloads/
      var downloadDirectory = await getDownloadsDirectory();

      if (downloadDirectory != null) {
        File file = File(
            '${downloadDirectory.path}/${date.toIso8601String().substring(0, 10)}_$fileName');
        if (!file.existsSync()) {
          file.createSync();
        }

        await file.writeAsString(backupJsonString, flush: true);

        return BackupResult.success;
      }

      return BackupResult.cancelled;
    } catch (e) {
      return BackupResult.failure;
    }
  }

  Future<bool> restore() async {
    return true;
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
