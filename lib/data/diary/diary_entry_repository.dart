import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:multiple_result/multiple_result.dart';

class DiaryEntryRepository {
  final HiveService _hiveService = HiveService.hiveService;

  Future<Result<Unit, Exception>> saveEntryAsync(DiaryEntry diaryEntry) async {
    try{
      if(diaryEntry.id == null) {
        diaryEntry.setId();
      }

      await _hiveService.diaryEntryBox.put(diaryEntry.id, diaryEntry);
      return const Success(unit);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> saveAllEntriesAsync(List<DiaryEntry> diaryEntries) async {
    try{
      await _hiveService.diaryEntryBox.putAll(Map.fromEntries(diaryEntries.map((x) => MapEntry(x.id, x))));
      return const Success(unit);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Result<DiaryEntry, Exception> getEntry(int id) {
    try{
      var result = _hiveService.diaryEntryBox.get(id);

      if(result == null) {
        return Error(Exception('Entry not found'));
      }

      return Success(result);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Result<List<DiaryEntry>, Exception> getAllEntries() {
    try{
      var result = _hiveService.diaryEntryBox.values.orderByDescending((x) => x.date).toList();
      return Success(result);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Result<List<DiaryEntry>, Exception> getAllEntriesByDogDate(
      int dogId,
      DateTime startDate,
      DateTime endDate)
  {
    try{
      var result = _hiveService.diaryEntryBox.values
          .where((x) => x.dogId == dogId
                && x.date.compareTo(startDate) >= 0
                && x.date.compareTo(endDate) <= 0)
          .orderByDescending((x) => x.date)
          .toList();
      return Success(result);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> deleteEntryAsync(int id) async {
    try{
      await _hiveService.diaryEntryBox.delete(id);
      return const Success(unit);
    } on Exception catch (e){
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> deleteAllEntriesAsync() async {
    try{
      await _hiveService.diaryEntryBox.clear();
      return const Success(unit);
    } on Exception catch (e){
      return Error(e);
    }

  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DiaryEntryRepository>(() => DiaryEntryRepository());
  }

  static DiaryEntryRepository get diaryEntryRepository {
    return ServiceProvider.locator<DiaryEntryRepository>();
  }
}