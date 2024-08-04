import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/factories/testfactories.dart';
import '../../mocks.dart';

void main(){
  final mockGoRouter = MockGoRouter();
  final MockShowDiaryEntryViewmodel mockShowDiaryEntryViewModel = MockShowDiaryEntryViewmodel();

  setUpAll(() {
    GetIt.I.registerFactory<ShowDiaryEntryViewmodel>(() => mockShowDiaryEntryViewModel);
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  testWidgets("Should show empty widget when no dogs found", (tester) async{
    //arrange
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(List.empty());
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(false);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDiaryEntryTab(),
    ));

    //assert
    final text = find.text('You have no dogs added yet');
    expect(text, findsOneWidget);
  });

  testWidgets("Should create new dog on add button when no dogs exist", (tester) async{
    //arrange
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(List.empty());
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(false);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());
    when(() => mockGoRouter.push(any())).thenAnswer((_) => Future.value());

    //act
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const ShowDiaryEntryTab()
      ),
    ));

    final btnAddDiaryEntry = find.byKey(const Key("btnAddDiaryEntry"), skipOffstage: false);
    await tester.ensureVisible(btnAddDiaryEntry);

    await tester.tap(btnAddDiaryEntry);

    //assert
    verify(() => mockGoRouter.push('/dog/new-dog')).called(1);
  });

  testWidgets("Should create new diary entry on add button when dogs exist", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());
    when(() => mockGoRouter.push(any())).thenAnswer((_) => Future.value());

    //act
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const ShowDiaryEntryTab()
      ),
    ));

    final btnAddDiaryEntry = find.byKey(const Key("btnAddDiaryEntry"), skipOffstage: false);
    await tester.ensureVisible(btnAddDiaryEntry);

    await tester.tap(btnAddDiaryEntry);

    //assert
    verify(() => mockGoRouter.push('/diary/new-entry')).called(1);
  });

  testWidgets("Should show dogs, when found", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDiaryEntryTab(),
    ));

    //assert
    final rudiFinder = find.text('Rudi');
    final monteFinder = find.text('Monte');
    final wilmaFinder = find.text('Wilma');
    expect(rudiFinder, findsOneWidget);
    expect(monteFinder, findsOneWidget);
    expect(wilmaFinder, findsOneWidget);
  });

  testWidgets("Should not show dogSports when no diary entries", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDiaryEntryTab(),
    ));

    final rudiFinder = find.text('Rudi');
    final obiFinderFirstTry = find.text('Obedience');
    expect(obiFinderFirstTry, findsNothing);

    await tester.tap(rudiFinder);

    //assert
    final obiFinderSecondTry = find.text('Obedience');
    expect(obiFinderSecondTry, findsNothing);
  });

  testWidgets("Should show dogsports when diaryEntries exist", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    List<DiaryEntry> lstDiaryEntires = [
      TestFactories.createDiaryEntry(1, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), DateTime.now().subtract(const Duration(days: 2))),
      TestFactories.createDiaryEntry(2, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), DateTime.now().subtract(const Duration(days: 1))),
      TestFactories.createDiaryEntry(3, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), DateTime.now())
    ];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(lstDiaryEntires);

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDiaryEntryTab(),
    ));

    //assert
    final obiFinderFirstTry = find.text('Obedience');
    expect(obiFinderFirstTry, findsOneWidget);
  });

  /*testWidgets("Should show diaryEntries when tap on dogsports", (tester) async{
    //arrange
    final day1 = DateTime.now().subtract(const Duration(days: 2));
    final day2 = DateTime.now().subtract(const Duration(days: 1));
    final day3 = DateTime.now();

    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    List<DiaryEntry> lstDiaryEntires = [
      TestFactories.createDiaryEntry(1, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), day1),
      TestFactories.createDiaryEntry(2, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), day2),
      TestFactories.createDiaryEntry(3, 1, Tuple(DogSports.obedience, DogSportsClasses.obedienceOB), day3)
    ];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(lstDiaryEntires);

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDiaryEntryTab(),
    ));

    final rudiFinder = find.widgetWithText(ExpansionTile, 'Rudi');
    expect(rudiFinder, findsOneWidget);

    final obiFinder = find.descendant(of: rudiFinder, matching: find.widgetWithText(ExpansionTile, 'Obedience'));
    expect(obiFinder, findsOneWidget);

    await tester.tap(obiFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    //assert
    final diaryEntry1 = find.text(DateFormat('yyyy-MM-dd').format(day1));
    final diaryEntry2 = find.text(DateFormat('yyyy-MM-dd').format(day2));
    final diaryEntry3 = find.text(DateFormat('yyyy-MM-dd').format(day3));

    expect(diaryEntry1, findsOneWidget);
    expect(diaryEntry2, findsOneWidget);
    expect(diaryEntry3, findsOneWidget);
  });

  testWidgets("Should edit diary entry when tap on entry", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDiaryEntryViewModel.dogs).thenReturn(lstDog);
    when(() => mockShowDiaryEntryViewModel.hasAnyDogs()).thenReturn(true);
    when(() => mockShowDiaryEntryViewModel.diaryEntries).thenReturn(List.empty());
    when(() => mockGoRouter.push(any())).thenAnswer((_) => Future.value());

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const ShowDiaryEntryTab()
      ),
    ));

    //act
    final rudiFinder = find.text('Rudi');
    await tester.tap(rudiFinder);

    //assert
    verify(() => mockGoRouter.push('/dog/1')).called(1);
  });*/
}