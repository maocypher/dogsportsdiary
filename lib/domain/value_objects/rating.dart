import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';

class Rating{
  final Exercises exercise;
  final double rating;
  final bool isPlanned;
  final String? notes;
  bool editMode = false;

  Rating({required this.exercise, required this.rating, required this.isPlanned, this.notes});

  Rating copyWith({
    Exercises? exercise,
    double? rating,
    bool? isPlanned,
    String? notes
  }) {
    return Rating(
        exercise: exercise ?? this.exercise,
        rating: rating ?? this.rating,
        isPlanned: isPlanned ?? this.isPlanned,
        notes: notes ?? this.notes
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.exercise: exercise.toJson(),
      Constants.rating: rating,
      Constants.isPlanned: isPlanned,
      Constants.notes: notes
    };
  }

  static Rating fromJson(Map<String, dynamic> json) {
    var isPlanned = json[Constants.isPlanned];
    var notes = json[Constants.notes];

    return Rating(
        exercise:  ExercisesJsonExtension.fromJson(json[Constants.exercise] as String),
        rating: json[Constants.rating] as double,
        isPlanned:  isPlanned != null ? isPlanned as bool : false,
        notes: notes ?? ""
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