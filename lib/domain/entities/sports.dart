import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

enum DogSports {
  agility,
  //jumping,
  obedience,
  rallyObedience,
  thsVk,
  thsDk;
  //cc;

  @override
  String toString() {
    return DogSportConstants.dogSportToJson[this]!;
  }
}

class DogSportConstants {
  static const Map<DogSports, String> dogSportToJson = {
    DogSports.agility: 'agility',
    //DogSports.jumping: 'jumping',
    DogSports.obedience: 'obedience',
    DogSports.rallyObedience: 'rallyo',
    DogSports.thsVk: 'thsVk',
    DogSports.thsDk: 'thsDk',
    //DogSports.cc: 'cc',
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
      DogSportsClasses.agilityAS
    ],
    /*DogSports.jumping: [
      DogSportsClasses.jumpingJP0,
      DogSportsClasses.jumpingJP1,
      DogSportsClasses.jumpingJP2,
      DogSportsClasses.jumpingJP3,
      DogSportsClasses.jumpingJPS
    ],*/
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
    DogSports.thsVk: [
      DogSportsClasses.thsVK1,
      DogSportsClasses.thsVK2,
      DogSportsClasses.thsVK3
    ],
    DogSports.thsDk: [
      DogSportsClasses.thsDK1,
      DogSportsClasses.thsDK2,
      DogSportsClasses.thsDK3,
    ],
    /*DogSports.cc: [
      DogSportsClasses.canicross
    ],*/
  };

  static Map<Tuple<DogSports, DogSportsClasses>, List<Exercises>> get sportsExercises => {
    // Obedience
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
    ],
    Tuple(DogSports.obedience, DogSportsClasses.obedienceOS): [
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

    //Rally-Obedience
    Tuple(DogSports.rallyObedience, DogSportsClasses.rallyObedienceROB): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.stop,
      Exercises.down,
      Exercises.sit,
      Exercises.stay,
      Exercises.turn,
      Exercises.turnLeft,
      Exercises.turnRight,
      Exercises.sitInFront,
      Exercises.slalom,
      Exercises.eight,
      Exercises.goRound,
      Exercises.back,
      Exercises.spiral
    ],
    Tuple(DogSports.rallyObedience, DogSportsClasses.rallyObedienceRO1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.stop,
      Exercises.down,
      Exercises.sit,
      Exercises.stay,
      Exercises.turn,
      Exercises.turnLeft,
      Exercises.turnRight,
      Exercises.sitInFront,
      Exercises.slalom,
      Exercises.eight,
      Exercises.goRound,
      Exercises.back,
      Exercises.spiral,
      Exercises.positionFromMovement,
      Exercises.sidewards,
      Exercises.stand
    ],
    Tuple(DogSports.rallyObedience, DogSportsClasses.rallyObedienceRO2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.stop,
      Exercises.down,
      Exercises.sit,
      Exercises.stay,
      Exercises.turn,
      Exercises.turnLeft,
      Exercises.turnRight,
      Exercises.sitInFront,
      Exercises.slalom,
      Exercises.eight,
      Exercises.goRound,
      Exercises.back,
      Exercises.spiral,
      Exercises.positionFromMovement,
      Exercises.sidewards,
      Exercises.stand,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.twist
    ],
    Tuple(DogSports.rallyObedience, DogSportsClasses.rallyObedienceRO3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.stop,
      Exercises.down,
      Exercises.sit,
      Exercises.stay,
      Exercises.turn,
      Exercises.turnLeft,
      Exercises.turnRight,
      Exercises.sitInFront,
      Exercises.slalom,
      Exercises.eight,
      Exercises.goRound,
      Exercises.back,
      Exercises.spiral,
      Exercises.positionFromMovement,
      Exercises.sidewards,
      Exercises.stand,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.twist,
      Exercises.distanceControl
    ],
    Tuple(DogSports.rallyObedience, DogSportsClasses.rallyObedienceROS): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.stop,
      Exercises.down,
      Exercises.sit,
      Exercises.stay,
      Exercises.turn,
      Exercises.turnLeft,
      Exercises.turnRight,
      Exercises.sitInFront,
      Exercises.slalom,
      Exercises.eight,
      Exercises.goRound,
      Exercises.back,
      Exercises.spiral,
      Exercises.positionFromMovement,
      Exercises.sidewards,
      Exercises.stand,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.twist,
      Exercises.distanceControl
    ],

    //Agility
    Tuple(DogSports.agility, DogSportsClasses.agilityA0): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.awall,
      Exercises.hoop,
      Exercises.broadJump,
      Exercises.footbridge,
      Exercises.tunnel
    ],
    Tuple(DogSports.agility, DogSportsClasses.agilityA1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.hoop,
      Exercises.broadJump,
      Exercises.footbridge,
      Exercises.seesaw,
      Exercises.tunnel
    ],
    Tuple(DogSports.agility, DogSportsClasses.agilityA2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.hoop,
      Exercises.broadJump,
      Exercises.footbridge,
      Exercises.seesaw,
      Exercises.tunnel
    ],
    Tuple(DogSports.agility, DogSportsClasses.agilityA3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.hoop,
      Exercises.broadJump,
      Exercises.footbridge,
      Exercises.seesaw,
      Exercises.tunnel
    ],
    Tuple(DogSports.agility, DogSportsClasses.agilityAS): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.awall,
      Exercises.broadJump,
      Exercises.footbridge,
      Exercises.seesaw,
      Exercises.tunnel
    ],

    //THS VK
    Tuple(DogSports.thsVk, DogSportsClasses.thsVK1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],
    Tuple(DogSports.thsVk, DogSportsClasses.thsVK2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],
    Tuple(DogSports.thsVk, DogSportsClasses.thsVK3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heelParking,
      Exercises.heelAngle,
      Exercises.heelSpeedSlow,
      Exercises.heelSpeedNormal,
      Exercises.heelSpeedFast,
      Exercises.positionFromMovement,
      Exercises.distanceControl,
      Exercises.recall,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],

    //THS DK
    Tuple(DogSports.thsDk, DogSportsClasses.thsDK1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],
    Tuple(DogSports.thsDk, DogSportsClasses.thsDK2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],
    Tuple(DogSports.thsDk, DogSportsClasses.thsDK3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.hurdle,
      Exercises.slalom,
      Exercises.awall,
      Exercises.tunnel,
      Exercises.footbridge,
      Exercises.hoop,
      Exercises.broadJump
    ],
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