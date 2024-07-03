import 'package:dog_sports_diary/app/app.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/data/diary/diary_adapter.dart';
import 'package:dog_sports_diary/data/dogs/dog_adapter.dart';
import 'package:dog_sports_diary/data/settings/settings_adapter.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();

  ServiceProvider.injectAll();
  runApp(const DogSportsApp());
}

Future<void> initializeHive() async {
  final directory = await getApplicationDocumentsDirectory();
  final hivePath = directory.path;
  Hive.init(hivePath);

  Hive.registerAdapter(DiaryEntryAdapter());
  Hive.registerAdapter(DogAdapter());

  await Hive.openBox<Dog>(Constants.dogBox);
  await Hive.openBox<DiaryEntry>(Constants.diaryBox);
}