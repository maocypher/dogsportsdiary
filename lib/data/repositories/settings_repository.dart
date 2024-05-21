import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/settings.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  final Box<Settings> _SettingsBox;

  SettingsRepository() : _SettingsBox = Hive.box<Settings>('settingsBox');

  Future<void> saveSettings(Settings settings) async {
    await _SettingsBox.put(settings.id, settings);
  }

  Future<Settings?> getSettings(int id) async {
    return _SettingsBox.get(id);
  }

  Future<List<Settings>> getAllSettingss() async {
    return _SettingsBox.values.toList();
  }

  Future<void> deleteSettings(int id) async {
    await _SettingsBox.delete(id);
  }

  Future<void> closeBox() async {
    await _SettingsBox.close();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<SettingsRepository>(() => SettingsRepository());
  }

  static SettingsRepository get settingsRepository {
    return ServiceProvider.locator<SettingsRepository>();
  }
}