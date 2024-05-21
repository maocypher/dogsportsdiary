import 'package:dog_sports_diary/data/repositories/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/repositories/dog_repository.dart';
import 'package:dog_sports_diary/data/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';

interface class ServiceProvider {

  static final locator = GetIt.I;

  static injectAll() {
    DogRepository.inject();
    DiaryEntryRepository.inject();
    SettingsRepository.inject();
  }
}