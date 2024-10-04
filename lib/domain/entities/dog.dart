import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/value_objects/sports.dart';
import 'package:dog_sports_diary/domain/value_objects/sports_classes.dart';

class Dog implements Entity{
  @override
  int? id;
  final String name;
  final DateTime dateOfBirth;
  final Map<DogSports, DogSportsClasses> sports;
  double? weight;
  String? imagePath;

  Dog({
    this.id,
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
    Map<DogSports, DogSportsClasses>? sports,
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
      id: json[DogConstants.id],
      name: json[DogConstants.name],
      dateOfBirth: DateTime.parse(json[DogConstants.dateOfBirth]),
      sports: DogSportsMapJsonExtension.fromJson(json[DogConstants.sports]),
      weight: json[DogConstants.weight],
      imagePath: json[DogConstants.imagePath]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DogConstants.id: id,
      DogConstants.name: name,
      DogConstants.dateOfBirth: dateOfBirth.toString(),
      DogConstants.sports: sports.toJson(),
      DogConstants.weight: weight,
      DogConstants.imagePath: imagePath
    };
  }

  @override
  void setId(){
    id = hashCode;
  }

  @override
  int get hashCode => name.hashCode ^ dateOfBirth.hashCode;

  @override
  bool operator ==(Object other){
    return other is Dog
        && other.id == id;
  }
}

class DogConstants{
  static const String id = 'id';
  static const String name = 'name';
  static const String dateOfBirth = 'dateOfBirth';
  static const String sports = 'sports';
  static const String weight = 'weight';
  static const String imagePath = 'imagePath';
}