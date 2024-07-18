import 'dart:convert';

import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';

enum BackupResult{
  unknown,
  success,
  failure,
  cancelled
}

class Backup{
  final DateTime date;
  final List<Dog> dogs;
  final List<DiaryEntry> diaryEntries;

  Backup({required this.dogs, required this.diaryEntries, required this.date});

  static Backup fromJson(Map<String, dynamic> json){
    var date = DateTime.parse(json[BackupConstants.date]);

    //json[BackupConstants.dogs] to List<dog>
    List<Dog> dogsFromJson = json[BackupConstants.dogs].map<Dog>((e) => Dog.fromJson(e)).toList();
    List<DiaryEntry> diaryEntriesFromJson = json[BackupConstants.diaryEntries].map<DiaryEntry>((e) => DiaryEntry.fromJson(e)).toList();

    return Backup(dogs: dogsFromJson, diaryEntries: diaryEntriesFromJson, date: date);
  }

  static Backup fromJsonString(String jsonString){
    return fromJson(jsonDecode(jsonString));
  }

  Map<String, dynamic> toJson(){
    return {
      BackupConstants.date: date.toString(),
      BackupConstants.dogs: dogs.map((e) => e.toJson()).toList(),
      BackupConstants.diaryEntries: diaryEntries.map((e) => e.toJson()).toList(),
    };
  }

  String toJsonString(){
    return jsonEncode(toJson());
  }
}

class BackupConstants{
  static const String date = 'date';
  static const String dogs = 'dogs';
  static const String diaryEntries = 'diaryEntries';
}