import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';

class Dog implements Entity{
  @override
  final int id;
  final String name;
  final DateTime dateOfBirth;
  final List<Sports> sports;
  double? weight;
  String? imagePath;

  Dog({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.sports,
    this.weight,
    this.imagePath
  });

  Dog copyWith({
    int? id,
    String? name,
    DateTime? dateOfBirth,
    List<Sports>? sports,
    double? weight,
    String? imagePath
  }) {
    return Dog(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sports: sports ?? this.sports,
      weight: weight ?? this.weight,
      imagePath: imagePath ?? this.imagePath
    );
  }

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      sports: json['sports'].map<Sports>((json) => SportsJsonExtension.fromJson(json)).toList(),
      weight: json['weight'],
      imagePath: json['imagePath']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.toString(),
      'sports': sports.map((sport) => sport.toJson()).toList(),
      'weight': weight,
      'imagePath': imagePath
    };
  }
}