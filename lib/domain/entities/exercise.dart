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
  //rallyo
  //ths
  //agility
  //jumping
}

class ExercisesConstants{
  static const String motivation = 'motivation';
  static const String concentration = 'concentration';
  static const String excitement = 'excitement';

  static const String heelwork = 'heelwork';
  static const String heelParking = 'heel_parking';
  static const String heelAngle = 'heel_angle';
  static const String heelEndurance = 'heel_endurance';
  static const String heelSpeedSlow = 'heel_speed_slow';
  static const String heelSpeedNormal = 'heel_speed_normal';
  static const String heelSpeedFast = 'heel_speed_fast';

  static const String group = 'group';
  static const String positionFromMovement = 'position_from_movement';
  static const String distanceControl = 'distance_control';
  static const String retrieve = 'retrieve';
  static const String retrieveKeepCalm = 'retrieve_keep_calm';
  static const String retrieveFastPickUp = 'retrieve_fast_pick_up';
  static const String retrieveSpeed = 'retrieve_speed';
  static const String retrieveDelivery = 'retrieve_delivery';
  static const String retrieveParking = 'retrieve_parking';
  static const String square = 'square';
  static const String recall = 'recall';
  static const String cones = 'cones';
  static const String hurdle = 'hurdle';
  static const String scent = 'scent';
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