import 'package:dog_sports_diary/core/utils/constants.dart';

class TrainingGoals {
  final String title;
  final bool isReached;

  const TrainingGoals({
    required this.title,
    this.isReached = false,
  });

  TrainingGoals copyWith({String? title, bool? isReached}) {
    return TrainingGoals(
      title: title ?? this.title,
      isReached: isReached ?? this.isReached,
    );
  }

  TrainingGoals markAsReached() {
    return copyWith(isReached: true);
  }

  TrainingGoals markAsUnreached() {
    return copyWith(isReached: false);
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.trainingGoalTitle: title,
      Constants.trainingGoalIsReached: isReached
    };
  }

  static TrainingGoals fromJson(Map<String, dynamic> json) {
    return TrainingGoals(
        title: json[Constants.trainingGoalTitle],
        isReached: json[Constants.trainingGoalIsReached]
    );
  }
}
