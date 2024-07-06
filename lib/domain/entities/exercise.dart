import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';

enum Exercises{
  //General
  motivation,
  concentration,
  excitement,
  //heelwork
  heelwork,
  heelParking,
  heelAngle,
  heelEndurance,
  heelSpeedSlow,
  heelSpeedNormal,
  heelSpeedFast,
  //obedience
  group,
  positionFromMovement,
  distanceControl,
  retrieve,
  retrieveKeepCalm,
  retrieveFastPickUp,
  retrieveSpeed,
  retrieveDelivery,
  retrieveParking,
  square,
  recall,
  cones,
  hurdle,
  scent,
  stand,
  //rallyo
  stop,
  down,
  sit,
  stay,
  turn,
  turnLeft,
  turnRight,
  sitInFront,
  slalom,
  eight,
  goRound,
  back,
  spiral,
  sidewards,
  twist,
  //ths
  //agility
  awall,
  hoop,
  broadJump,
  footbridge,
  seesaw,
  tunnel,
  //jumping
}

class ExercisesConstants{
  static const String motivation = 'motivation';
  static const String concentration = 'concentration';
  static const String excitement = 'excitement';

  static const String heelwork = 'heelwork';
  static const String heelParking = 'heelParking';
  static const String heelAngle = 'heelAngle';
  static const String heelEndurance = 'heelEndurance';
  static const String heelSpeedSlow = 'heelSpeedSlow';
  static const String heelSpeedNormal = 'heelSpeedNormal';
  static const String heelSpeedFast = 'heelSpeedFast';

  static const String group = 'group';
  static const String positionFromMovement = 'positionFromMovement';
  static const String distanceControl = 'distanceControl';
  static const String retrieve = 'retrieve';
  static const String retrieveKeepCalm = 'retrieveKeepCalm';
  static const String retrieveFastPickUp = 'retrieveFastPickUp';
  static const String retrieveSpeed = 'retrieveSpeed';
  static const String retrieveDelivery = 'retrieveDelivery';
  static const String retrieveParking = 'retrieveParking';
  static const String square = 'square';
  static const String recall = 'recall';
  static const String cones = 'cones';
  static const String hurdle = 'hurdle';
  static const String scent = 'scent';

  static const String stand = 'stand';
  static const String stop = 'stop';
  static const String down = 'down';
  static const String sit = 'sit';
  static const String stay = 'stay';
  static const String turn = 'turn';
  static const String turnLeft = 'turnLeft';
  static const String turnRight = 'turnRight';
  static const String sitInFront = 'sitInFront';
  static const String slalom = 'slalom';
  static const String eight = 'eight';
  static const String goRound = 'goRound';
  static const String back = 'back';
  static const String spiral = 'spiral';
  static const String sidewards = 'sidewards';
  static const String twist = 'twist';
  static const String awall = 'awall';
  static const String hoop = 'hoop';
  static const String broadJump = 'broadJump';
  static const String footbridge = 'footbridge';
  static const String seesaw = 'seesaw';
  static const String tunnel = 'tunnel';
}

extension ExercisesJsonExtension on Exercises {
  String toJson() {
    switch (this) {
      case Exercises.motivation:
        return ExercisesConstants.motivation;
      case Exercises.concentration:
        return ExercisesConstants.concentration;
      case Exercises.excitement:
        return ExercisesConstants.excitement;
      case Exercises.heelwork:
        return ExercisesConstants.heelwork;
      case Exercises.heelParking:
        return ExercisesConstants.heelParking;
      case Exercises.heelAngle:
        return ExercisesConstants.heelAngle;
      case Exercises.heelEndurance:
        return ExercisesConstants.heelEndurance;
      case Exercises.heelSpeedSlow:
        return ExercisesConstants.heelSpeedSlow;
      case Exercises.heelSpeedNormal:
        return ExercisesConstants.heelSpeedNormal;
      case Exercises.heelSpeedFast:
        return ExercisesConstants.heelSpeedFast;
      case Exercises.group:
        return ExercisesConstants.group;
      case Exercises.positionFromMovement:
        return ExercisesConstants.positionFromMovement;
      case Exercises.distanceControl:
        return ExercisesConstants.distanceControl;
      case Exercises.retrieve:
        return ExercisesConstants.retrieve;
      case Exercises.retrieveKeepCalm:
        return ExercisesConstants.retrieveKeepCalm;
      case Exercises.retrieveFastPickUp:
        return ExercisesConstants.retrieveFastPickUp;
      case Exercises.retrieveSpeed:
        return ExercisesConstants.retrieveSpeed;
      case Exercises.retrieveDelivery:
        return ExercisesConstants.retrieveDelivery;
      case Exercises.retrieveParking:
        return ExercisesConstants.retrieveParking;
      case Exercises.square:
        return ExercisesConstants.square;
      case Exercises.recall:
        return ExercisesConstants.recall;
      case Exercises.cones:
        return ExercisesConstants.cones;
      case Exercises.hurdle:
        return ExercisesConstants.hurdle;
      case Exercises.scent:
        return ExercisesConstants.scent;
      case Exercises.stand:
        return ExercisesConstants.stand;
      case Exercises.stop:
        return ExercisesConstants.stop;
      case Exercises.down:
        return ExercisesConstants.down;
      case Exercises.sit:
        return ExercisesConstants.sit;
      case Exercises.stay:
        return ExercisesConstants.stay;
      case Exercises.turn:
        return ExercisesConstants.turn;
      case Exercises.turnLeft:
        return ExercisesConstants.turnLeft;
      case Exercises.turnRight:
        return ExercisesConstants.turnRight;
      case Exercises.sitInFront:
        return ExercisesConstants.sitInFront;
      case Exercises.slalom:
        return ExercisesConstants.slalom;
      case Exercises.eight:
        return ExercisesConstants.eight;
      case Exercises.goRound:
        return ExercisesConstants.goRound;
      case Exercises.back:
        return ExercisesConstants.back;
      case Exercises.spiral:
        return ExercisesConstants.spiral;
      case Exercises.sidewards:
        return ExercisesConstants.sidewards;
      case Exercises.twist:
        return ExercisesConstants.twist;
      case Exercises.awall:
        return ExercisesConstants.awall;
      case Exercises.hoop:
        return ExercisesConstants.hoop;
      case Exercises.broadJump:
        return ExercisesConstants.broadJump;
      case Exercises.footbridge:
        return ExercisesConstants.footbridge;
      case Exercises.seesaw:
        return ExercisesConstants.seesaw;
      case Exercises.tunnel:
        return ExercisesConstants.tunnel;
      default:
        throw FormatException('Invalid exercise value: $this');
    }
  }

  static Exercises fromJson(String json) {
    switch (json) {
      case ExercisesConstants.motivation:
        return Exercises.motivation;
      case ExercisesConstants.concentration:
        return Exercises.concentration;
      case ExercisesConstants.excitement:
        return Exercises.excitement;
      case ExercisesConstants.heelwork:
        return Exercises.heelwork;
      case ExercisesConstants.heelParking:
        return Exercises.heelParking;
      case ExercisesConstants.heelAngle:
        return Exercises.heelAngle;
      case ExercisesConstants.heelEndurance:
        return Exercises.heelEndurance;
      case ExercisesConstants.heelSpeedSlow:
        return Exercises.heelSpeedSlow;
      case ExercisesConstants.heelSpeedNormal:
        return Exercises.heelSpeedNormal;
      case ExercisesConstants.heelSpeedFast:
        return Exercises.heelSpeedFast;
      case ExercisesConstants.group:
        return Exercises.group;
      case ExercisesConstants.positionFromMovement:
        return Exercises.positionFromMovement;
      case ExercisesConstants.distanceControl:
        return Exercises.distanceControl;
      case ExercisesConstants.retrieve:
        return Exercises.retrieve;
      case ExercisesConstants.retrieveKeepCalm:
        return Exercises.retrieveKeepCalm;
      case ExercisesConstants.retrieveFastPickUp:
        return Exercises.retrieveFastPickUp;
      case ExercisesConstants.retrieveSpeed:
        return Exercises.retrieveSpeed;
      case ExercisesConstants.retrieveDelivery:
        return Exercises.retrieveDelivery;
      case ExercisesConstants.retrieveParking:
        return Exercises.retrieveParking;
      case ExercisesConstants.square:
        return Exercises.square;
      case ExercisesConstants.recall:
        return Exercises.recall;
      case ExercisesConstants.cones:
        return Exercises.cones;
      case ExercisesConstants.hurdle:
        return Exercises.hurdle;
      case ExercisesConstants.scent:
        return Exercises.scent;
      case ExercisesConstants.stand:
        return Exercises.stand;
      case ExercisesConstants.stop:
        return Exercises.stop;
      case ExercisesConstants.down:
        return Exercises.down;
      case ExercisesConstants.sit:
        return Exercises.sit;
      case ExercisesConstants.stay:
        return Exercises.stay;
      case ExercisesConstants.turn:
        return Exercises.turn;
      case ExercisesConstants.turnLeft:
        return Exercises.turnLeft;
      case ExercisesConstants.turnRight:
        return Exercises.turnRight;
      case ExercisesConstants.sitInFront:
        return Exercises.sitInFront;
      case ExercisesConstants.slalom:
        return Exercises.slalom;
      case ExercisesConstants.eight:
        return Exercises.eight;
      case ExercisesConstants.goRound:
        return Exercises.goRound;
      case ExercisesConstants.back:
        return Exercises.back;
      case ExercisesConstants.spiral:
        return Exercises.spiral;
      case ExercisesConstants.sidewards:
        return Exercises.sidewards;
      case ExercisesConstants.twist:
        return Exercises.twist;
      case ExercisesConstants.awall:
        return Exercises.awall;
      case ExercisesConstants.hoop:
        return Exercises.hoop;
      case ExercisesConstants.broadJump:
        return Exercises.broadJump;
      case ExercisesConstants.footbridge:
        return Exercises.footbridge;
      case ExercisesConstants.seesaw:
        return Exercises.seesaw;
      case ExercisesConstants.tunnel:
        return Exercises.tunnel;
      default:
        throw FormatException('Invalid exercise value: $json');
    }
  }
}

extension ExercisesRankingJsonExtension on Tuple<Exercises, double>{
  Map<String, dynamic> toJson() {
    return {Constants.exercise: key.toJson(), Constants.rating: value};
  }

  static Tuple<Exercises, double> fromJson(Map<String, dynamic> json) {
    return Tuple(ExercisesJsonExtension.fromJson(json[Constants.exercise] as String), json[Constants.rating] as double);
  }
}

extension ExercisesRankingListJsonExtension on List<Tuple<Exercises, double>>{
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  static List<Tuple<Exercises, double>> fromJson(List<dynamic> json) {
    return json.map((e) => ExercisesRankingJsonExtension.fromJson(e as Map<String, dynamic>)).toList();
  }
}