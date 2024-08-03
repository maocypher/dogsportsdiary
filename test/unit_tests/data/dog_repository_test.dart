import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/factories/testfactories.dart';
import '../../mocks.dart';

void main(){
  final MockHiveService mockHiveService = MockHiveService();
  final MockBox<Dog> mockBox = MockBox<Dog>();

  group("saveDogAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);

      registerFallbackValue(TestFactories.createDog(null, null));
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenThrow(Exception());

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.saveDogAsync(inputData);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putIsSuccessful", () async {
      //arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.saveDogAsync(inputData);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("saveAllDogsAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);

      registerFallbackValue(TestFactories.createDog(null, null));
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_putAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenThrow(Exception());

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.saveAllDogsAsync([inputData]);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_putAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.putAll(any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.saveAllDogsAsync([inputData]);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("getDogAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_getIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.get(any())).thenThrow(Exception());

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = cut.getDog(inputData.id!);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_getIsSuccessful", () async {
      //arrange
      when(() => mockBox.get(any())).thenAnswer((_) => TestFactories.createDog(null, null));

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = cut.getDog(inputData.id!);

      //assert
      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess()!.id, inputData.id);
    });
  });

  group("getAllDogsAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_getAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.values).thenThrow(Exception());

      var cut = DogRepository();

      //act
      var result = cut.getAllDogs();

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_getAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.values).thenAnswer((_) => [TestFactories.createDog(null, null)]);

      var cut = DogRepository();

      //act
      var result = cut.getAllDogs();

      //assert
      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess()!.length, 1);
    });
  });

  group("deleteDogAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_deleteIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.delete(any())).thenThrow(Exception());

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.deleteDogAsync(inputData.id!);

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_deleteIsSuccessful", () async {
      //arrange
      when(() => mockBox.delete(any())).thenAnswer((_) async => 1);

      var inputData = TestFactories.createDog(null, null);
      var cut = DogRepository();

      //act
      var result = await cut.deleteDogAsync(inputData.id!);

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("deleteAllDogsAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_deleteAllIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.clear()).thenThrow(Exception());

      var cut = DogRepository();

      //act
      var result = await cut.deleteAllDogsAsync();

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_deleteAllIsSuccessful", () async {
      //arrange
      when(() => mockBox.clear()).thenAnswer((_) async => 1);

      var cut = DogRepository();

      //act
      var result = await cut.deleteAllDogsAsync();

      //assert
      expect(result.isSuccess(), true);
    });
  });

  group("hasAnyDogAsync", (){
    setUpAll(() {
      GetIt.I.registerFactory<HiveService>(() => mockHiveService);

      when(() => mockHiveService.dogBox).thenReturn(mockBox);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    test("should_returnFailure_when_hasAnyIsNotSuccessful", () async {
      //arrange
      when(() => mockBox.isNotEmpty).thenThrow(Exception());

      var cut = DogRepository();

      //act
      var result = cut.hasAnyDogs();

      //assert
      expect(result.isError(), true);
    });

    test("should_returnSuccess_when_hasAnyIsSuccessful", () async {
      //arrange
      when(() => mockBox.isNotEmpty).thenAnswer((_) => true);

      var cut = DogRepository();

      //act
      var result = cut.hasAnyDogs();

      //assert
      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess(), true);
    });
  });
}