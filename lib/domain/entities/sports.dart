import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

enum DogSports {
  agility,
  obedience,
  rallyObedience,
  ths;

  @override
  String toString() {
    return DogSportConstants.dogSportToJson[this]!;
  }
}

class DogSportConstants {
  static const Map<DogSports, String> dogSportToJson = {
    DogSports.agility: 'agility',
    DogSports.obedience: 'obedience',
    DogSports.rallyObedience: 'rallyo',
    DogSports.ths: 'ths',
  };

  static Map<String, DogSports> jsonToDogSport = Map.fromEntries(dogSportToJson.entries.map((e) => MapEntry(e.value, e.key)));
}

class Sports {
  static final Map<DogSports, List<DogSportsClasses>> sportsClasses = {
    DogSports.agility: [
      DogSportsClasses.agilityA0,
      DogSportsClasses.agilityA1,
      DogSportsClasses.agilityA2,
      DogSportsClasses.agilityA3,
      DogSportsClasses.agilityAS,
      DogSportsClasses.jumpingJP0,
      DogSportsClasses.jumpingJP1,
      DogSportsClasses.jumpingJP2,
      DogSportsClasses.jumpingJP3,
      DogSportsClasses.jumpingJPS
    ],
    DogSports.obedience: [
      DogSportsClasses.obedienceOB,
      DogSportsClasses.obedienceO1,
      DogSportsClasses.obedienceO2,
      DogSportsClasses.obedienceO3,
      DogSportsClasses.obedienceOS
    ],
    DogSports.rallyObedience: [
      DogSportsClasses.rallyObedienceROB,
      DogSportsClasses.rallyObedienceRO1,
      DogSportsClasses.rallyObedienceRO2,
      DogSportsClasses.rallyObedienceRO3,
      DogSportsClasses.rallyObedienceROS
    ],
    DogSports.ths: [
      DogSportsClasses.thsVK1,
      DogSportsClasses.thsVK2,
      DogSportsClasses.thsVK3,
      DogSportsClasses.thsDK1,
      DogSportsClasses.thsDK2,
      DogSportsClasses.thsDK3,
      DogSportsClasses.canicross
    ]
  };

  static Map<Tuple<DogSports, DogSportsClasses>, List<Exercises>> get sportsExercises => {
    Tuple(DogSports.obedience, DogSportsClasses.obedienceOB): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.group,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.retrieve,
      Exercises.retrieveKeepCalm,
      Exercises.retrieveFastPickUp,
      Exercises.retrieveSpeed,
      Exercises.retrieveDelivery,
      Exercises.retrieveParking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
    ],
    Tuple(DogSports.obedience, DogSportsClasses.obedienceO1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.group,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.retrieve,
      Exercises.retrieveKeepCalm,
      Exercises.retrieveFastPickUp,
      Exercises.retrieveSpeed,
      Exercises.retrieveDelivery,
      Exercises.retrieveParking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
      Exercises.hurdle
    ],
    Tuple(DogSports.obedience, DogSportsClasses.obedienceO2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.group,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.retrieve,
      Exercises.retrieveKeepCalm,
      Exercises.retrieveFastPickUp,
      Exercises.retrieveSpeed,
      Exercises.retrieveDelivery,
      Exercises.retrieveParking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
      Exercises.hurdle,
      Exercises.scent
    ],
    Tuple(DogSports.obedience, DogSportsClasses.obedienceO3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.group,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.retrieve,
      Exercises.retrieveKeepCalm,
      Exercises.retrieveFastPickUp,
      Exercises.retrieveSpeed,
      Exercises.retrieveDelivery,
      Exercises.retrieveParking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
      Exercises.hurdle,
      Exercises.scent
    ]
  };
}

extension DogSportsJsonExtension on DogSports {
  String toJson() {
    return DogSportConstants.dogSportToJson[this]!;
  }

  static DogSports fromJson(String json) {
    return DogSportConstants.jsonToDogSport[json]!;
  }
}

extension DogSportsMapJsonExtension on Map<DogSports, DogSportsClasses> {

  Map<String, String> toJson() {
    return map((key, value) => MapEntry(key.toJson(), value.toJson()));
  }

  static Map<DogSports, DogSportsClasses> fromJson(Map<String, dynamic> json) {
    Map<DogSports, DogSportsClasses> sports = {};

    json.forEach((key, value) {
      var sport = DogSportsJsonExtension.fromJson(key);
      var classes = DogSportsClassesJsonExtension.fromJson(value);

      sports[sport] = classes;
    });

    return sports;
  }
}

extension DogSportsTupleJsonExtension on Tuple<DogSports, DogSportsClasses> {
  Map<String, dynamic> toJson() {
    return {Constants.sport: key.toJson(), Constants.classes: value.toJson()};
  }

  static Tuple<DogSports, DogSportsClasses> fromJson(Map<String, dynamic> json) {
    return Tuple(DogSportsJsonExtension.fromJson(json[Constants.sport]), DogSportsClassesJsonExtension.fromJson(json[Constants.classes]));
  }

  static List<Tuple<DogSports, DogSportsClasses>> toList(Map<DogSports, DogSportsClasses> sports){
    return sports.entries.map((sport) {
      return Tuple(sport.key, sport.value);
    }).toList();
  }

  static Tuple<DogSports, DogSportsClasses> toTuple(MapEntry<DogSports, DogSportsClasses> sport) {
    return Tuple(sport.key, sport.value);
  }
}