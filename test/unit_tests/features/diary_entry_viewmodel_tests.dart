import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../common/factories/testfactories.dart';
import '../../mocks.dart';

void main(){
  MockDogRepository mockDogRepository = MockDogRepository();
  MockDiaryEntryRepository mockDiaryEntryRepository = MockDiaryEntryRepository();
  MockToast mockToast = MockToast();

  group("initAsync", ()
  {
    setUpAll(() {
      GetIt.I.registerFactory<DogRepository>(() => mockDogRepository);
      GetIt.I.registerFactory<DiaryEntryRepository>(() => mockDiaryEntryRepository);
      GetIt.I.registerFactory<Toast>(() => mockToast);
    });

    tearDownAll(() {
      GetIt.I.reset();
      reset(mockDogRepository);
      reset(mockDiaryEntryRepository);
      reset(mockToast);
    });

    test("should_createDefaultDiaryEntry_when_idStrIsNull", () async {
      //arrange
      when(() => mockDogRepository.getAllDogs()).thenReturn(Success(List.empty()));
      var cut = DiaryEntryViewModel();

      //act
      var result = await cut.initAsync(null);

      //assert
      expect(result, isNotNull);
      expect(cut.diaryEntry, isNotNull);
      expect(cut.diaryEntry?.temperature, equals(Constants.initTemperature));
      expect(cut.diaryEntry?.trainingDurationInMin, equals(Constants.initMinutes));
      expect(cut.diaryEntry?.warmUpDurationInMin, equals(Constants.initMinutes));
      expect(cut.diaryEntry?.coolDownDurationInMin, equals(Constants.initMinutes));
    });

    test("should_showToast_when_diaryEntryNotFound", () async {
      //arrange
      when(() => mockDogRepository.getAllDogs()).thenReturn(Success(List.empty()));
      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Error(Exception('Entry not found')));

      var cut = DiaryEntryViewModel();

      //act
      await cut.initAsync("0");

      //assert
      verify(() => mockToast.showToast(msg: "Diary entry not found")).called(1);
    });

    test("should_notLoadDog_when_noDogAttachedToDiaryEntry", () async {
      //arrange
      var diaryEntry = TestFactories.createDiaryEntry(null, null, null, null);
      diaryEntry.dogId = null;
      when(() => mockDogRepository.getAllDogs()).thenReturn(Success(List.empty()));
      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Success(diaryEntry));

      var cut = DiaryEntryViewModel();

      //act
      await cut.initAsync("0");

      //assert
      verifyNever(() => mockDogRepository.getDog(any()));
    });

    test("should_loadDog_when_dogAttachedToDiaryEntry", () async {
      //arrange
      var diaryEntry = TestFactories.createDiaryEntry(null, null, null, null);
      var dog = TestFactories.createDog(null, null);
      when(() => mockDogRepository.getAllDogs()).thenReturn(Success(List.empty()));
      when(() => mockDogRepository.getDog(any())).thenReturn(Success(dog));
      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Success(diaryEntry));

      var cut = DiaryEntryViewModel();

      //act
      await cut.initAsync("0");

      //assert
      verify(() => mockDogRepository.getDog(diaryEntry.dogId!)).called(1);
    });
  });

  group("loadEntryAsync", ()
  {
    setUpAll(() {
      GetIt.I.registerFactory<DogRepository>(() => mockDogRepository);
      GetIt.I.registerFactory<
          DiaryEntryRepository>(() => mockDiaryEntryRepository);
      GetIt.I.registerFactory<Toast>(() => mockToast);
    });

    tearDownAll(() {
      GetIt.I.reset();
      reset(mockDogRepository);
      reset(mockDiaryEntryRepository);
      reset(mockToast);
    });

    test("should_showToastMessage_when_gettingEntryIsNotSuccessful", () async {
      //arrange
      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Error(Exception()));
      var cut = DiaryEntryViewModel();

      //act
      await cut.loadEntryAsync(0);

      //assert
      verify(() => mockDiaryEntryRepository.getEntry(any())).called(1);
      verify(() => mockToast.showToast(msg: "Diary entry not found")).called(1);
    });

    test("should_notLoadDog_when_dogIdIsNull", () async {
      //arrange
      var diaryEntry = TestFactories.createDiaryEntry(null, null, null, null);
      diaryEntry.dogId = null;

      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Success(diaryEntry));
      var cut = DiaryEntryViewModel();

      //act
      await cut.loadEntryAsync(0);

      //assert
      verify(() => mockDiaryEntryRepository.getEntry(any())).called(1);
      verifyNever(() => mockToast.showToast(msg: any(named: "msg")));
      verifyNever(() => mockDogRepository.getDog(any()));
    });

    test("should_loadDog_when_dogIdIsSet", () async {
      //arrange
      var diaryEntry = TestFactories.createDiaryEntry(null, null, null, null);
      var dog = TestFactories.createDog(null, null);

      when(() => mockDiaryEntryRepository.getEntry(any())).thenReturn(Success(diaryEntry));
      when(() => mockDogRepository.getDog(any())).thenReturn(Success(dog));

      var cut = DiaryEntryViewModel();

      //act
      await cut.loadEntryAsync(0);

      //assert
      verify(() => mockDiaryEntryRepository.getEntry(any())).called(1);
      verifyNever(() => mockToast.showToast(msg: any(named: "msg")));
      verify(() => mockDogRepository.getDog(diaryEntry.dogId!)).called(1);
    });
  });

  group("loadDogsAsync", ()
  {
    setUpAll(() {
      GetIt.I.registerFactory<DogRepository>(() => mockDogRepository);
      GetIt.I.registerFactory<
          DiaryEntryRepository>(() => mockDiaryEntryRepository);
      GetIt.I.registerFactory<Toast>(() => mockToast);
    });

    tearDownAll(() {
      GetIt.I.reset();
      reset(mockDogRepository);
      reset(mockDiaryEntryRepository);
      reset(mockToast);
    });

    test("should_showToastMessage_when_loadingDogsIsNotSuccessful", () async {
      //arrange
      when(() => mockDogRepository.getAllDogs()).thenReturn(
          Error(Exception()));
      var cut = DiaryEntryViewModel();

      //act
      await cut.loadDogsAsync();

      //assert
      verify(() => mockDogRepository.getAllDogs()).called(1);
      verify(() => mockToast.showToast(msg: "Error loading dogs")).called(1);
    });

    test("should_notLoadDog_when_dogListIsEmpty", () async {
      //arrange
      when(() => mockDogRepository.getAllDogs()).thenReturn(
          const Success([]));
      var cut = DiaryEntryViewModel();

      //act
      await cut.loadDogsAsync();

      //assert
      verify(() => mockDogRepository.getAllDogs()).called(1);
      verifyNever(() => mockDogRepository.getDog(any()));
    });

    test("should_notLoadDog_when_dogIsAlreadySelected", () async {
      //arrange
      var dog = TestFactories.createDog(null, null);
      var lstDog = [dog, dog, dog];

      when(() => mockDogRepository.getAllDogs()).thenReturn(
          Success(lstDog));
      when(() => mockDogRepository.getDog(any())).thenReturn(Success(dog));

      var cut = DiaryEntryViewModel();
      cut.loadDogAsync(0, null);

      reset(mockDogRepository);

      when(() => mockDogRepository.getAllDogs()).thenReturn(
          Success(lstDog));
      when(() => mockDogRepository.getDog(any())).thenReturn(Success(dog));

      //act
      await cut.loadDogsAsync();

      //assert
      verify(() => mockDogRepository.getAllDogs()).called(1);
      verifyNever(() => mockDogRepository.getDog(any()));
    });

    test("should_loadDog_when_noDogIsSelected", () async {
      //arrange
      var dog = TestFactories.createDog(null, null);
      var lstDog = [dog, dog, dog];

      when(() => mockDogRepository.getAllDogs()).thenReturn(
          Success(lstDog));
      when(() => mockDogRepository.getDog(any())).thenReturn(Success(dog));

      var cut = DiaryEntryViewModel();
      
      //act
      await cut.loadDogsAsync();

      //assert
      verify(() => mockDogRepository.getAllDogs()).called(1);
      verify(() => mockDogRepository.getDog(any())).called(1);
    });
  });

  group("loadDogAsync", ()
  {
    setUpAll(() {
      GetIt.I.registerFactory<DogRepository>(() => mockDogRepository);
      GetIt.I.registerFactory<
          DiaryEntryRepository>(() => mockDiaryEntryRepository);
      GetIt.I.registerFactory<Toast>(() => mockToast);
    });

    tearDownAll(() {
      GetIt.I.reset();
      reset(mockDogRepository);
      reset(mockDiaryEntryRepository);
      reset(mockToast);
    });

    test("should_showToastMessage_when_dogNotFound", () async {
      //arrange
      when(() => mockDogRepository.getDog(any())).thenReturn(
          Error(Exception()));
      var cut = DiaryEntryViewModel();

      //act
      await cut.loadDogAsync(0, null);

      //assert
      verify(() => mockDogRepository.getDog(any())).called(1);
      verify(() => mockToast.showToast(msg: "Dog not found")).called(1);
    });
  });
}