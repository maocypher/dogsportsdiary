import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/domain/value_objects/settings.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  Future<void> saveSettings(Settings settings) async {
    final settingsBox = Hive.box<Settings>('settingsBox');
    await settingsBox.put(settings.id, settings);
  }

  Future<Settings?> getSettings(int id) async {
    final settingsBox = Hive.box<Settings>('settingsBox');
    final settings = settingsBox.get(id);

    return settings;
  }

  Future<List<Settings>> getAllSettings() async {
    final settingsBox = Hive.box<Settings>('settingsBox');
    final settings = settingsBox.values.toList();

    return settings;
  }

  Future<void> deleteSettings(int id) async {
    final settingsBox = Hive.box<Settings>('settingsBox');
    await settingsBox.delete(id);
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<SettingsRepository>(() => SettingsRepository());
  }

  static SettingsRepository get settingsRepository {
    return ServiceProvider.locator<SettingsRepository>();
  }
}