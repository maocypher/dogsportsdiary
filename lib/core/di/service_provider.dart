import 'package:dog_sports_diary/core/services/backup_service.dart';
import 'package:dog_sports_diary/core/services/history_service.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/core/services/overview_service.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/data/settings/settings_repository.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dog_sports_diary/features/history/history_viewmodel.dart';
import 'package:dog_sports_diary/features/overview/overview_viewmodel.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:get_it/get_it.dart';

interface class ServiceProvider {

  static final locator = GetIt.I;

  static injectAll() {
    //infrastructure
    HiveService.inject();

    //Dogs
    DogRepository.inject();
    ShowDogsViewModel.inject();
    DogViewModel.inject();

    //Diary
    DiaryEntryRepository.inject();
    ShowDiaryEntryViewmodel.inject();
    DiaryEntryViewModel.inject();

    //Settings
    SettingsRepository.inject();
    SettingsViewModel.inject();

    //Overview
    OverviewViewModel.inject();
    HistoryViewModel.inject();

    //Services
    BackupService.inject();
    OverviewService.inject();
    HistoryService.inject();
    Toast.inject();
  }
}