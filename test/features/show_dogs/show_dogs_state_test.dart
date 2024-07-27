import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../factories/testfactories.dart';
import '../../mocks.dart';

void main(){
  final mockGoRouter = MockGoRouter();
  final MockShowDogsViewModel mockShowDogsViewModel = MockShowDogsViewModel();

  setUpAll(() {
    GetIt.I.registerFactory<ShowDogsViewModel>(() => mockShowDogsViewModel);
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  testWidgets("Show empty widget when no dogs", (tester) async{
    //arrange
    when(() => mockShowDogsViewModel.dogs).thenReturn(List.empty());

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDogsTab(),
    ));

    //assert
    final text = find.text('Press the + button to add a dog');
    expect(text, findsOneWidget);
  });

  testWidgets("Should create new dog on add button", (tester) async{
    //arrange
    when(() => mockShowDogsViewModel.dogs).thenReturn(List.empty());
    when(() => mockGoRouter.push(any())).thenAnswer((_) => Future.value());

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(
        goRouter: mockGoRouter,
        child: const ShowDogsTab()
      ),
    ));

    //act
    final btnAddDog = find.byKey(const Key("btnAddDog"), skipOffstage: false);
    await tester.ensureVisible(btnAddDog);

    await tester.tap(btnAddDog);

    //assert
    verify(() => mockGoRouter.push('/dog/new-dog')).called(1);
  });

  testWidgets("Show dogs when found", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDogsViewModel.dogs).thenReturn(lstDog);

    //act
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShowDogsTab(),
    ));

    //assert
    final rudiFinder = find.text('Rudi');
    final monteFinder = find.text('Monte');
    final wilmaFinder = find.text('Wilma');
    expect(rudiFinder, findsOneWidget);
    expect(monteFinder, findsOneWidget);
    expect(wilmaFinder, findsOneWidget);
  });

  testWidgets("Should edit dog on tab dog", (tester) async{
    //arrange
    List<Dog> lstDog = [TestFactories.createDog(1, 'Rudi'), TestFactories.createDog(2, 'Monte'), TestFactories.createDog(3, 'Wilma')];
    when(() => mockShowDogsViewModel.dogs).thenReturn(lstDog);
    when(() => mockGoRouter.push(any())).thenAnswer((_) => Future.value());

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const ShowDogsTab()
      ),
    ));

    //act
    final rudiFinder = find.text('Rudi');
    await tester.tap(rudiFinder);

    //assert
    verify(() => mockGoRouter.push('/dog/1')).called(1);
  });
}