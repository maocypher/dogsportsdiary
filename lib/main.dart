import 'package:dog_sports_diary/app/app.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  ServiceProvider.injectAll();
  runApp(const DogSportsApp());
  Hive.init('db');
  await Hive.openBox('myBox');
}