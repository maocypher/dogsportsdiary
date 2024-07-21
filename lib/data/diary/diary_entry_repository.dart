import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/core/utils/result.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';

class DiaryEntryRepository {
  final HiveService _hiveService = HiveService.hiveService;

  Future<Result<void, Exception>> saveEntryAsync(DiaryEntry diaryEntry) async {
    try{
      if(diaryEntry.id == null) {
        diaryEntry.setId();
      }

      throw Exception();

      await _hiveService.diaryEntryBox.put(diaryEntry.id, diaryEntry);

      return const Success(null);
    } on Exception catch (e){
      return Failure(e);
    }
  }

  Future<void> saveAllEntriesAsync(List<DiaryEntry> diaryEntries) async {
    await _hiveService.diaryEntryBox.putAll(Map.fromEntries(diaryEntries.map((x) => MapEntry(x.id, x))));
  }

  Future<DiaryEntry?> getEntryAsync(int id) async {
    return _hiveService.diaryEntryBox.get(id);
  }

  Future<List<DiaryEntry>> getAllEntiresAsync() async {
    return _hiveService.diaryEntryBox.values.orderByDescending((x) => x.date).toList();
  }

  Future<void> deleteEntryAsync(int id) async {
    await _hiveService.diaryEntryBox.delete(id);
  }


  Future<void> deleteAllEntriesAsync() async {
    await _hiveService.diaryEntryBox.clear();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DiaryEntryRepository>(() => DiaryEntryRepository());
  }

  static DiaryEntryRepository get diaryEntryRepository {
    return ServiceProvider.locator<DiaryEntryRepository>();
  }
}