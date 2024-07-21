import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/data/diary/diary_adapter.dart';
import 'package:dog_sports_diary/data/dogs/dog_adapter.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService{

  final Box<DiaryEntry> _diaryBox = Hive.box<DiaryEntry>(Constants.diaryBox);
  final Box<Dog> _dogBox = Hive.box<Dog>(Constants.dogBox);

  static Future<void> initAsync() async {
    final directory = await getApplicationDocumentsDirectory();
    final hivePath = directory.path;
    await Hive.initFlutter(hivePath);

    Hive.registerAdapter(DiaryEntryAdapter());
    Hive.registerAdapter(DogAdapter());

    await Hive.openBox<Dog>(Constants.dogBox, compactionStrategy: (entries, deletedValue) {
      return deletedValue >= 1;
    });
    await Hive.openBox<DiaryEntry>(Constants.diaryBox, compactionStrategy: (entries, deletedValue) {
      return deletedValue >= 1;
    });
  }

  Future<void> closeAsync() async {
    await Hive.close();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<HiveService>(() => HiveService());
  }

  static HiveService get hiveService {
    return ServiceProvider.locator<HiveService>();
  }
}