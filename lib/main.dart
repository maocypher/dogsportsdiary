import 'package:dog_sports_diary/app/app.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.initAsync();

  ServiceProvider.injectAll();
  runApp(const DogSportsApp());
}