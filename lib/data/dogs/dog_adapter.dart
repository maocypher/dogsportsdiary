import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class DogAdapter extends TypeAdapter<Dog> {
  @override
  final int typeId = 1;

  @override
  Dog read(BinaryReader reader) {
    final json = reader.readString();
    final map = jsonDecode(json);
    return Dog.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Dog obj) {
    final json = jsonEncode(obj);
    writer.writeString(json);
  }
}