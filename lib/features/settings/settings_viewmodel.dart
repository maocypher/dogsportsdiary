import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/services/backup_service.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  final BackupService backupService = BackupService.backupService;

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<SettingsViewModel>(() => SettingsViewModel());
  }

  static SettingsViewModel get settingsViewModel {
    return ServiceProvider.locator<SettingsViewModel>();
  }
}