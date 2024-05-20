import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMigrationManager {
  static final DatabaseMigrationManager _instance = DatabaseMigrationManager._internal();

  static DatabaseMigrationManager get instance => _instance;

  Database? _database;
  DatabaseMigrationManager._internal();

  Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'dogsports_diary.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, dateOfBirth TEXT, weight REAL, image TEXT)',
        );
      },
      version: 1,
      /*onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          // Migration from version 1 to version 2
          // Add a new column to the dogs table
          db.execute('ALTER TABLE dogs ADD COLUMN age INTEGER');
        }
        if (oldVersion < 3) {
          // Migration from version 2 to version 3
          // Create a new table for dog owners
          db.execute(
            'CREATE TABLE dog_owners(id INTEGER PRIMARY KEY, name TEXT, dog_id INTEGER)',
          );
        }
      },
      version: 3,*/
    );
  }
}