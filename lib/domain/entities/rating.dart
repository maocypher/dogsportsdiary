import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';

class Rating{
  final Exercises exercise;
  final double rating;
  final bool isPlanned;

  Rating({required this.exercise, required this.rating, required this.isPlanned});

  Map<String, dynamic> toJson() {
    return {
      Constants.exercise: exercise.toJson(),
      Constants.rating: rating,
      Constants.isPlanned: isPlanned
    };
  }

  static Rating fromJson(Map<String, dynamic> json) {
    var isPlanned = json[Constants.isPlanned];

    return Rating(
        exercise:  ExercisesJsonExtension.fromJson(json[Constants.exercise] as String),
        rating: json[Constants.rating] as double,
        isPlanned:  isPlanned != null ? isPlanned as bool : false
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