import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../factories/testfactories.dart';
import '../mocks.dart';

void main(){
  final MockHiveService mockHiveService = MockHiveService();
  final MockBox<DiaryEntry> mockBox = MockBox<DiaryEntry>();

  group("saveEntryAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);

      registerFallbackValue(TestFactories.createDiaryEntry());
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry();
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveEntryAsync(inputData);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putIsSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDiaryEntry();
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveEntryAsync(inputData);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("saveAllEntriesAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);

      registerFallbackValue(TestFactories.createDiaryEntry());
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry();
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveAllEntriesAsync([inputData]);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDiaryEntry();
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveAllEntriesAsync([inputData]);

      //assert
      expect(result.isSuccess(), true);
    });
  });
}