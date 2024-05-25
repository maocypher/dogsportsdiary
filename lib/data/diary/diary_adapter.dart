import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class DiaryEntryAdapter extends TypeAdapter<DiaryEntry> {
  @override
  final int typeId = 2;

  @override
  DiaryEntry read(BinaryReader reader) {
    final json = reader.readString();
    final map = jsonDecode(json);
    return DiaryEntry.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, DiaryEntry obj) {
    final json = jsonEncode(obj);
    writer.writeString(json);
  }
}