import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveService extends Mock implements HiveService {}

class MockBox<T> extends Mock implements Box<T>{}