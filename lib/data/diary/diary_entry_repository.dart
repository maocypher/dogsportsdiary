import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:hive/hive.dart';

class DiaryEntryRepository {
  final Box<DiaryEntry> _diaryEntryBox;

  DiaryEntryRepository() : _diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');

  Future<void> saveEntry(DiaryEntry diaryEntry) async {
    await _diaryEntryBox.put(diaryEntry.date, diaryEntry);
  }

  Future<DiaryEntry?> getEntry(DateTime date) async {
    return _diaryEntryBox.get(date);
  }

  Future<List<DiaryEntry>> getAllEntires() async {
    return _diaryEntryBox.values.toList();
  }

  Future<void> deleteEntry(int id) async {
    await _diaryEntryBox.delete(id);
  }

  Future<void> closeBox() async {
    await _diaryEntryBox.close();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DiaryEntryRepository>(() => DiaryEntryRepository());
  }

  static DiaryEntryRepository get diaryEntryRepository {
    return ServiceProvider.locator<DiaryEntryRepository>();
  }
}