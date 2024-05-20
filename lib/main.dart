import 'package:dog_sports_diary/app/app.dart';
import 'package:dog_sports_diary/data/database_migration_manager.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const DogSportsApp());
  await DatabaseMigrationManager.instance.initialize();
}