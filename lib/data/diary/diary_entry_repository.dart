import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:hive/hive.dart';

class DiaryEntryRepository {

  Future<void> saveEntryAsync(DiaryEntry diaryEntry) async {
    final diaryEntryBox = Hive.box<DiaryEntry>(Constants.diaryBox);

    if(diaryEntry.id == null) {
      diaryEntry.setId();
    }

    await diaryEntryBox.put(diaryEntry.id, diaryEntry);
  }

  Future<DiaryEntry?> getEntryAsync(int id) async {
    final diaryEntryBox = Hive.box<DiaryEntry>(Constants.diaryBox);
    return diaryEntryBox.get(id);
  }

  Future<List<DiaryEntry>> getAllEntiresAsync() async {
    final diaryEntryBox = Hive.box<DiaryEntry>(Constants.diaryBox);
    return diaryEntryBox.values.toList();
  }

  Future<void> deleteEntryAsync(int id) async {
    final diaryEntryBox = Hive.box<DiaryEntry>(Constants.diaryBox);
    await diaryEntryBox.delete(id);
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DiaryEntryRepository>(() => DiaryEntryRepository());
  }

  static DiaryEntryRepository get diaryEntryRepository {
    return ServiceProvider.locator<DiaryEntryRepository>();
  }
}