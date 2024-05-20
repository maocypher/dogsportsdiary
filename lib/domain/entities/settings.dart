import 'package:dog_sports_diary/domain/abstractions/entity.dart';

class Settings implements Entity{
  final int id;
  final String name;
  final DateTime dateOfBirth;

  Settings({
    required this.id,
    required this.name,
    required this.dateOfBirth,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
    };
  }
}