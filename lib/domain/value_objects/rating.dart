import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';
import 'package:dog_sports_diary/domain/value_objects/training_goal.dart';

class Rating{
  final Exercises exercise;
  final double rating;
  final bool isPlanned;
  final TrainingGoals? trainingGoals;
  bool editMode = false;

  Rating({required this.exercise, required this.rating, required this.isPlanned, this.trainingGoals});

  Rating copyWith({
    Exercises? exercise,
    double? rating,
    bool? isPlanned,
    TrainingGoals? trainingGoals
  }) {
    return Rating(
        exercise: exercise ?? this.exercise,
        rating: rating ?? this.rating,
        isPlanned: isPlanned ?? this.isPlanned,
        trainingGoals: trainingGoals ?? this.trainingGoals
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.exercise: exercise.toJson(),
      Constants.rating: rating,
      Constants.isPlanned: isPlanned,
      Constants.trainingGoals: trainingGoals?.toJson()
    };
  }

  static Rating fromJson(Map<String, dynamic> json) {
    var isPlanned = json[Constants.isPlanned];
    var trainingGoals = json[Constants.trainingGoals];

    return Rating(
        exercise:  ExercisesJsonExtension.fromJson(json[Constants.exercise] as String),
        rating: json[Constants.rating] as double,
        isPlanned:  isPlanned != null ? isPlanned as bool : false,
        trainingGoals: trainingGoals != null ? TrainingGoals.fromJson(trainingGoals) : null
    );
  }
}

extension ExercisesRankingListJsonExtension on List<Rating>{
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  static List<Rating> fromJson(List<dynamic> json) {
    return json.map((e) => Rating.fromJson(e as Map<String, dynamic>)).toList();
  }
}