import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/rating.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

class TestFactories{
  static DiaryEntry createDiaryEntry() {
    return DiaryEntry(
        id: 1,
        date: DateTime.now(),
        dogId: 1,
        sport: Tuple(DogSports.obedience, DogSportsClasses.obedienceOB),
        exerciseRating: [Rating(rating: 1, isPlanned: true, exercise: Exercises.heelwork)],
        trainingGoal: '',
        highlight: '',
        distractions: '',
        notes: '',
        temperature: 0.0,
        trainingDurationInMin: 0,
        warmUpDurationInMin: 0,
        coolDownDurationInMin: 0
    );
  }
}