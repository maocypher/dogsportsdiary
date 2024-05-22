import 'package:dog_sports_diary/app/app.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  ServiceProvider.injectAll();
  runApp(const DogSportsApp());

  final directory = await getApplicationDocumentsDirectory();
  final hivePath = directory.path;
  Hive.init(hivePath);

  await Hive.openBox('dogBox');
  await Hive.openBox('diaryEntryBox');
  await Hive.openBox('settingsBox');
}