import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class DogRepository extends ChangeNotifier {
  static Database? _database;

  Future<void> addDog(Dog dog) async {
    await _database?.insert(
      'dogs',
      dog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateDog(Dog dog) async {
    await _database?.update(
      'dogs',
      dog.toJson(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
    notifyListeners();
  }

  Future<void> deleteDog(String id) async {
    await _database?.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<List<Dog>> fetchDogs() async {
    final List<Map<String, dynamic>> maps = await _database?.query('dogs') ?? [];
    return List.generate(maps.length, (i) => Dog.fromJson(maps[i]));
  }
}