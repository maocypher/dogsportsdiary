import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

class DiaryEntry implements Entity{
  @override
  int? id;
  final DateTime date;
  int? dogId;
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
    this.id,
    required this.date,
    this.dogId,
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
    int? dogId,
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
        dogId: dogId ?? this.dogId,
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
      date: DateTime.parse(json['date']),
      dogId: json['dogId'],
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
      'date': date.toString(),
      'dogId': dogId,
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

  @override
  void setId(){
    id = hashCode;
  }

  @override
  int get hashCode => dogId.hashCode ^ date.hashCode ^ sport.hashCode;

  @override
  bool operator ==(Object other){
    return other is DiaryEntry
        && other.id == id;
  }
}