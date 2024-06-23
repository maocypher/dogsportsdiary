import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

class DiaryEntry implements Entity{
  @override
  final int id;
  final DateTime date;
  String? dogName;
  Tuple<DogSports, DogSportsClasses>? sport;
  List<Tuple<Exercises, double>>? exerciseRating;
  String? trainingGoal;
  String? highlight;
  String? distractions;
  String? notes;
  double? temperature;
  int? trainingDurationInMin;
  int? warmUpDurationInMin;
  int? coolDownDurationInMin;

  DiaryEntry({
    required this.id,
    required this.date,
    this.dogName,
    this.sport,
    this.exerciseRating,
    this.trainingGoal,
    this.highlight,
    this.distractions,
    this.notes,
    this.temperature,
    this.trainingDurationInMin,
    this.warmUpDurationInMin,
    this.coolDownDurationInMin
  });

  DiaryEntry copyWith({
    int? id,
    DateTime? date,
    String? dogName,
    Tuple<DogSports, DogSportsClasses>? sport,
    List<Tuple<Exercises, double>>? exerciseRating,
    String? trainingGoal,
    String? highlight,
    String? distractions,
    String? notes,
    double? temperature,
    int? trainingDurationInMin,
    int? warmUpDurationInMin,
    int? coolDownDurationInMin,
  }) {
    return DiaryEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        dogName: dogName ?? this.dogName,
        sport: sport ?? this.sport,
        exerciseRating: exerciseRating ?? this.exerciseRating,
        trainingGoal: trainingGoal ?? this.trainingGoal,
        highlight: highlight ?? this.highlight,
        distractions: distractions ?? this.distractions,
        notes: notes ?? this.notes,
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
      sport: DogSportsTupleJsonExtension.fromJson(json['sport']),
      exerciseRating: ExercisesRankingListJsonExtension.fromJson(json['exerciseRating']),
      trainingGoal: json['trainingGoal'],
      highlight: json['highlight'],
      distractions: json['distractions'],
      notes: json['notes'],
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
      'sport': sport?.toJson(),
      'exerciseRating': exerciseRating?.toJson(),
      'trainingGoal': trainingGoal,
      'highlight': highlight,
      'distractions': distractions,
      'notes': notes,
      'temperature': temperature,
      'trainingDurationInMin': trainingDurationInMin,
      'warmUpDurationInMin': warmUpDurationInMin,
      'coolDownDurationInMin': coolDownDurationInMin,
    };
  }
}