import 'package:dog_sports_diary/domain/value_objects/settings.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 0;

  @override
  Settings read(BinaryReader reader) {
    final json = reader.readString();
    final map = jsonDecode(json);
    return Settings.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    final json = jsonEncode(obj);
    writer.writeString(json);
  }
}