import 'package:dog_sports_diary/domain/abstractions/entity.dart';

class DiaryEntry implements Entity{
  final int id;
  final DateTime date;
  final String sport;
  final String sportClass;
  final String trainingGoal;
  final String highlight;
  final String distractions;
  final List<String> notes;
  final String entries;
  final int? temperature;
  final int? trainingDurationInMin;
  final int? warmUpDurationInMin;
  final int? coolDownDurationInMin;

  DiaryEntry({
    required this.id,
    required this.date,
    required this.sport,
    required this.sportClass,
    required this.trainingGoal,
    required this.highlight,
    required this.distractions,
    required this.notes,
    required this.entries,
    this.temperature,
    this.trainingDurationInMin,
    this.warmUpDurationInMin,
    this.coolDownDurationInMin
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      date: json['date'],
      sport: json['sport'],
      sportClass: json['sportClass'],
      trainingGoal: json['trainingGoal'],
      highlight: json['highlight'],
      distractions: json['distractions'],
      notes: json['notes'],
      entries: json['entries'],
      temperature: json['temperature'],
      trainingDurationInMin: json['trainingDurationInMin'],
      warmUpDurationInMin: json['warmUpDurationInMin'],
      coolDownDurationInMin: json['coolDownDurationInMin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'sport': sport,
      'sportClass': sportClass,
      'trainingGoal': trainingGoal,
      'highlight': highlight,
      'distractions': distractions,
      'notes': notes,
      'entries': entries,
      'temperature': temperature,
      'trainingDurationInMin': trainingDurationInMin,
      'warmUpDurationInMin': warmUpDurationInMin,
      'coolDownDurationInMin': coolDownDurationInMin,
    };
  }
}