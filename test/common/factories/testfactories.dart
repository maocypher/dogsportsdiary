import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/diary_entry.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/rating.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

class TestFactories{
  static DiaryEntry createDiaryEntry(int? id, int? dogId, Tuple<DogSports, DogSportsClasses>? dogSport, DateTime? date) {
    return DiaryEntry(
        id: id ?? 1,
        date: DateTime.now(),
        dogId: dogId ?? 1,
        sport: dogSport ?? Tuple(DogSports.obedience, DogSportsClasses.obedienceOB),
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

  static Dog createDog(int? id, String? name) {
    return Dog(
      id: id ?? 1,
      name: name ?? 'Rex',
      dateOfBirth: DateTime.now(),
      sports: Map<DogSports, DogSportsClasses>.fromEntries([
        const MapEntry(DogSports.obedience, DogSportsClasses.obedienceOB),
        const MapEntry(DogSports.rallyObedience, DogSportsClasses.rallyObedienceROB),
        const MapEntry(DogSports.thsVk, DogSportsClasses.thsVK1),
      ]),
      weight: 20.0,
      imagePath: 'image.png'
    );
  }

  static Dog initDog() {
    return Dog(
        name: '',
        dateOfBirth: DateTime.now(),
        sports: {},
        weight: Constants.initWeight
    );
  }
}