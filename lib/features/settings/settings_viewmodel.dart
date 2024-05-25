import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/data/settings/settings_repository.dart';
import 'package:dog_sports_diary/domain/entities/ranking.dart';
import 'package:dog_sports_diary/domain/entities/settings.dart';
import 'package:dog_sports_diary/domain/entities/theme.dart' as ds;
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository;
  late Settings _settings = Settings(ranking: Ranking.simple, theme: ds.Theme.system, id: 0);

  Settings get settings => _settings;

  SettingsViewModel(this._repository) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    var dbSetting = await _repository.getSettings(0);

    if(dbSetting != null) {
      _settings = dbSetting;
      notifyListeners();
    }
  }

  void updateRanking(Ranking ranking) {
    _settings = _settings.copyWith(ranking: ranking);
    notifyListeners();
  }

  void updateTheme(ds.Theme theme) {
    _settings = _settings.copyWith(theme: theme);
    notifyListeners();
  }

  void saveSettings() {
    _repository.saveSettings(_settings);
  }

  static inject() {
    // injecting the viewmodel
    final repository = ServiceProvider.locator<SettingsRepository>();
    ServiceProvider.locator.registerFactory<SettingsViewModel>(() => SettingsViewModel(repository));
  }

  static SettingsViewModel get settingsViewModel {
    return ServiceProvider.locator<SettingsViewModel>();
  }
}