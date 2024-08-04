import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/factories/testfactories.dart';
import '../../mocks.dart';

void main(){
  final MockHiveService mockHiveService = MockHiveService();
  final MockBox<DiaryEntry> mockBox = MockBox<DiaryEntry>();

  group("saveEntryAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);

      registerFallbackValue(TestFactories.createDiaryEntry(null, null, null, null));
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveEntryAsync(inputData);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putIsSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
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

      registerFallbackValue(TestFactories.createDiaryEntry(null, null, null, null));
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveAllEntriesAsync([inputData]);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.saveAllEntriesAsync([inputData]);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("getEntry", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_getIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.get(any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = cut.getEntry(inputData.id!);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_getIsSuccessful", () async {
      //arrange
      when(() => mockBox.get(any())).thenAnswer((_) => TestFactories.createDiaryEntry(null, null, null, null));

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = cut.getEntry(inputData.id!);

      //assert
      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess()!.id, inputData.id);
    });
  });

  group("getAllEntries", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_getAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.values).thenThrow(Exception());

      var cut = DiaryEntryRepository();

      //act
      var result = cut.getAllEntries();

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_getAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.values).thenAnswer((_) => [TestFactories.createDiaryEntry(null, null, null, null)]);

      var cut = DiaryEntryRepository();

      //act
      var result = cut.getAllEntries();

      //assert
      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess()!.length, 1);
    });
  });

  group("deleteEntryAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_deleteIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.delete(any())).thenThrow(Exception());

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.deleteEntryAsync(inputData.id!);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_deleteIsSuccessful", () async {
      //arrange
      when(() => mockBox.delete(any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDiaryEntry(null, null, null, null);
      var cut = DiaryEntryRepository();

      //act
      var result = await cut.deleteEntryAsync(inputData.id!);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("deleteAllEntriesAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.diaryEntryBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_deleteAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.clear()).thenThrow(Exception());

      var cut = DiaryEntryRepository();

      //act
      var result = await cut.deleteAllEntriesAsync();

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_deleteAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.clear()).thenAnswer((_) async => 1);

      var cut = DiaryEntryRepository();

      //act
      var result = await cut.deleteAllEntriesAsync();

      //assert
      expect(result.isSuccess(), true);
    });
  });
}