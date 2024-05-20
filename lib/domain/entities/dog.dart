import 'package:dog_sports_diary/domain/abstractions/entity.dart';

class Dog implements Entity{
  final int id;
  final String name;
  final DateTime dateOfBirth;
  final List<String> sports;
  double? weight;
  String? imageAsBase64;

  Dog({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.sports,
    this.weight,
    this.imageAsBase64
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      sports: json['sports'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'sports': sports,
      'weight': weight
    };
  }
}