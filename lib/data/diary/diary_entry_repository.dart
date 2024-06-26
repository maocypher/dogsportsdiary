import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:hive/hive.dart';

class DiaryEntryRepository {

  Future<void> saveEntry(DiaryEntry diaryEntry) async {
    final diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');
    diaryEntry.setId();

    await diaryEntryBox.put(diaryEntry.id, diaryEntry);
  }

  Future<DiaryEntry?> getEntry(int id) async {
    final diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');
    return diaryEntryBox.get(id);
  }

  Future<List<DiaryEntry>> getAllEntires() async {
    final diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');
    return diaryEntryBox.values.toList();
  }

  Future<void> deleteEntry(int id) async {
    final diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');
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