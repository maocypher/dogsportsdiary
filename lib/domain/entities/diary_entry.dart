import 'package:dog_sports_diary/domain/value_objects/rating.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/value_objects/sports.dart';
import 'package:dog_sports_diary/domain/value_objects/sports_classes.dart';

class DiaryEntry implements Entity{
  @override
  int? id;
  final DateTime date;
  int? dogId;
  Tuple<DogSports, DogSportsClasses>? sport;
  List<Rating>? exerciseRating;
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
    List<Rating>? exerciseRating,
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
      id: json[DiaryEntryConstants.id],
      date: DateTime.parse(json[DiaryEntryConstants.date]),
      dogId: json[DiaryEntryConstants.dogId],
      sport: DogSportsTupleJsonExtension.fromJson(json[DiaryEntryConstants.sport]),
      exerciseRating: ExercisesRankingListJsonExtension.fromJson(json[DiaryEntryConstants.exerciseRating]),
      trainingGoal: json[DiaryEntryConstants.trainingGoal],
      highlight: json[DiaryEntryConstants.highlight],
      distractions: json[DiaryEntryConstants.distractions],
      notes: json[DiaryEntryConstants.notes],
      temperature: json[DiaryEntryConstants.temperature],
      trainingDurationInMin: json[DiaryEntryConstants.trainingDurationInMin],
      warmUpDurationInMin: json[DiaryEntryConstants.warmUpDurationInMin],
      coolDownDurationInMin: json[DiaryEntryConstants.coolDownDurationInMin],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DiaryEntryConstants.id: id,
      DiaryEntryConstants.date: date.toString(),
      DiaryEntryConstants.dogId: dogId,
      DiaryEntryConstants.sport: sport!.toJson(),
      DiaryEntryConstants.exerciseRating: exerciseRating!.toJson(),
      DiaryEntryConstants.trainingGoal: trainingGoal,
      DiaryEntryConstants.highlight: highlight,
      DiaryEntryConstants.distractions: distractions,
      DiaryEntryConstants.notes: notes,
      DiaryEntryConstants.temperature: temperature,
      DiaryEntryConstants.trainingDurationInMin: trainingDurationInMin,
      DiaryEntryConstants.warmUpDurationInMin: warmUpDurationInMin,
      DiaryEntryConstants.coolDownDurationInMin: coolDownDurationInMin
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

class DiaryEntryConstants {
  static const String id = 'id';
  static const String date = 'date';
  static const String dogId = 'dogId';
  static const String sport = 'sport';
  static const String exerciseRating = 'exerciseRating';
  static const String trainingGoal = 'trainingGoal';
  static const String highlight = 'highlight';
  static const String distractions = 'distractions';
  static const String notes = 'notes';
  static const String temperature = 'temperature';
  static const String trainingDurationInMin = 'trainingDurationInMin';
  static const String warmUpDurationInMin = 'warmUpDurationInMin';
  static const String coolDownDurationInMin = 'coolDownDurationInMin';
}