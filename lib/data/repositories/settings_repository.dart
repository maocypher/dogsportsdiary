import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/settings.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  final Box<Settings> settingsBox;

  SettingsRepository() : settingsBox = Hive.box<Settings>('settingsBox');

  Future<void> saveSettings(Settings settings) async {
    await settingsBox.put(settings.id, settings);
  }

  Future<Settings?> getSettings(int id) async {
    return settingsBox.get(id);
  }

  Future<List<Settings>> getAllSettingss() async {
    return settingsBox.values.toList();
  }

  Future<void> deleteSettings(int id) async {
    await settingsBox.delete(id);
  }

  Future<void> closeBox() async {
    await settingsBox.close();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<SettingsRepository>(() => SettingsRepository());
  }

  static SettingsRepository get settingsRepository {
    return ServiceProvider.locator<SettingsRepository>();
  }
}