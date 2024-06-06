import 'package:dog_sports_diary/domain/abstractions/entity.dart';

class DiaryEntry implements Entity{
  @override
  final int id;
  final DateTime date;
  String? dogName;
  String? sport;
  String? sportClass;
  String? trainingGoal;
  String? highlight;
  String? distractions;
  List<String>? notes = List.empty(growable: true);
  String? entries;
  int? temperature;
  int? trainingDurationInMin;
  int? warmUpDurationInMin;
  int? coolDownDurationInMin;

  DiaryEntry({
    required this.id,
    required this.date,
    this.dogName,
    this.sport,
    this.sportClass,
    this.trainingGoal,
    this.highlight,
    this.distractions,
    this.notes,
    this.entries,
    this.temperature,
    this.trainingDurationInMin,
    this.warmUpDurationInMin,
    this.coolDownDurationInMin
  });

  DiaryEntry copyWith({
    int? id,
    DateTime? date,
    String? dogName,
    String? sport,
    String? sportClass,
    String? trainingGoal,
    String? highlight,
    String? distractions,
    List<String>? notes,
    String? entries,
    int? temperature,
    int? trainingDurationInMin,
    int? warmUpDurationInMin,
    int? coolDownDurationInMin,
  }) {
    return DiaryEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        dogName: dogName ?? this.dogName,
        sport: sport ?? this.sport,
        sportClass: sportClass ?? this.sportClass,
        trainingGoal: trainingGoal ?? this.trainingGoal,
        highlight: highlight ?? this.highlight,
        distractions: distractions ?? this.distractions,
        notes: notes ?? this.notes,
        entries: entries ?? this.entries,
        temperature: temperature ?? this.temperature,
        trainingDurationInMin: trainingDurationInMin ?? this.trainingDurationInMin,
        warmUpDurationInMin: warmUpDurationInMin ?? this.warmUpDurationInMin,
        coolDownDurationInMin: coolDownDurationInMin ?? this.coolDownDurationInMin
    );
  }

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      date: json['date'],
      dogName: json['dogName'],
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
      'dogName': dogName,
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