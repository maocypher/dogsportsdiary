import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/data/settings/settings_repository.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:get_it/get_it.dart';

interface class ServiceProvider {

  static final locator = GetIt.I;

  static injectAll() {
    //Dogs
    DogRepository.inject();
    ShowDogsViewModel.inject();
    DogViewModel.inject();

    //Diary
    DiaryEntryRepository.inject();
    DiaryEntryViewModel.inject();

    //Settings
    SettingsRepository.inject();
    SettingsViewModel.inject();
  }
}