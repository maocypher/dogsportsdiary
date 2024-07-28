import 'dart:async';

import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../factories/testfactories.dart';
import '../mocks.dart';

void main() {
  final MockDogViewModel mockShowDogsViewModel = MockDogViewModel();

  group("newDog", () {
    setUpAll(() {
      GetIt.I.registerFactory<DogViewModel>(() => mockShowDogsViewModel);
      when(() => mockShowDogsViewModel.initAsync(any())).thenAnswer((_) => Future.value());
      when(() => mockShowDogsViewModel.sportList).thenReturn(Sports.sportsClasses.keys.toList());
      when(() => mockShowDogsViewModel.selectedSports).thenReturn(ValueNotifier<List<DogSports>>([]));
      when(() => mockShowDogsViewModel.sportClasses).thenReturn(Sports.sportsClasses);
      when(() => mockShowDogsViewModel.selectedDogSportsStream).thenAnswer((_) => StreamController<List<DogSports>>().stream);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    testWidgets("Show empty widget when no dog exists", (tester) async {
      //arrange
      final dateOfBirth = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final Dog initDog = TestFactories.initDog();
      when(() => mockShowDogsViewModel.dog).thenReturn(initDog);
      when(() => mockShowDogsViewModel.dateOfBirth).thenReturn(dateOfBirth);

      //act
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DogTab(),
      ));

      //assert
      final txtBoxName = find.byKey(const Key("txtBoxName"));
      final txtBoxDateOfBirth = find.byKey(const Key("txtBoxDateOfBirth"));
      final txtBoxWeight = find.byKey(const Key("txtBoxWeight"));
      final drpDownObedience = find.byKey(const Key("drpDownobedience"));

      expect((tester.widget(txtBoxName) as TextFormField).controller!.text, isEmpty);
      expect((tester.widget(txtBoxDateOfBirth) as TextFormField).controller!.text, dateOfBirth);
      expect((tester.widget(txtBoxWeight) as TextFormField).controller!.text, "0.0");
      expect(drpDownObedience, findsNothing);
    });
  });

  group("editDog", () {
    setUpAll(() {
      List<DogSports> selectedSports = [DogSports.obedience, DogSports.rallyObedience];

      GetIt.I.registerFactory<DogViewModel>(() => mockShowDogsViewModel);
      when(() => mockShowDogsViewModel.initAsync(any())).thenAnswer((_) => Future.value());
      when(() => mockShowDogsViewModel.sportList).thenReturn(Sports.sportsClasses.keys.toList());
      when(() => mockShowDogsViewModel.sportClasses).thenReturn(Sports.sportsClasses);
      when(() => mockShowDogsViewModel.selectedSports).thenReturn(ValueNotifier<List<DogSports>>(selectedSports));
      when(() => mockShowDogsViewModel.selectedDogSportsStream).thenAnswer((_) => StreamController<List<DogSports>>().stream);
    });

    tearDownAll(() {
      GetIt.I.reset();
    });

    testWidgets("Show prefilled widget when dog exists", (tester) async {
      //arrange
      final Dog dog = TestFactories.createDog(1, "Rudi");
      final dateOfBirth = DateFormat('yyyy-MM-dd').format(dog.dateOfBirth);
      when(() => mockShowDogsViewModel.dog).thenReturn(dog);
      when(() => mockShowDogsViewModel.dateOfBirth).thenReturn(dateOfBirth);

      //act
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DogTab(),
      ));

      //assert
      final txtBoxName = find.byKey(const Key("txtBoxName"));
      final txtBoxDateOfBirth = find.byKey(const Key("txtBoxDateOfBirth"));
      final txtBoxWeight = find.byKey(const Key("txtBoxWeight"));
      final drpDownObedience = find.byKey(const Key("drpDownobedience"));

      expect((tester.widget(txtBoxName) as TextFormField).controller!.text, dog.name);
      expect((tester.widget(txtBoxDateOfBirth) as TextFormField).controller!.text, dateOfBirth);
      expect((tester.widget(txtBoxWeight) as TextFormField).controller!.text, dog.weight.toString());
      expect(drpDownObedience, findsOneWidget);
    });
  });
}