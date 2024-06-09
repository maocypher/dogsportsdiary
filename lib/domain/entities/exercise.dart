import 'dart:convert';

import 'package:dog_sports_diary/core/utils/tuple.dart';

enum Exercises{
  //General
  motivation,
  concentration,
  excitement,
  //heelwork
  heelwork,
  heel_parking,
  heel_angle,
  heel_endurance,
  heel_speed_slow,
  heel_speed_normal,
  heel_speed_running,
  //obedience
  group,
  position_from_movement,
  distance_control,
  retrieve,
  retrieve_keep_calm,
  retrieve_fast_pick_up,
  retrieve_speed,
  retrieve_delivery,
  retrieve_parking,
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

extension ExercisesJsonExtension on Exercises {
  String toJson() {
    switch (this) {
      case Exercises.motivation:
        return 'motivation';
      case Exercises.concentration:
        return 'concentration';
      case Exercises.excitement:
        return 'excitement';
      case Exercises.heelwork:
        return 'heelwork';
      case Exercises.heel_parking:
        return 'heel_parking';
      case Exercises.heel_angle:
        return 'heel_angle';
      case Exercises.heel_endurance:
        return 'heel_endurance';
      case Exercises.heel_speed_slow:
        return 'heel_speed_slow';
      case Exercises.heel_speed_normal:
        return 'heel_speed_normal';
      case Exercises.heel_speed_running:
        return 'heel_speed_running';
      case Exercises.group:
        return 'group';
      case Exercises.position_from_movement:
        return 'position_from_movement';
      case Exercises.distance_control:
        return 'distance_control';
      case Exercises.retrieve:
        return 'retrieve';
      case Exercises.retrieve_keep_calm:
        return 'retrieve_keep_calm';
      case Exercises.retrieve_fast_pick_up:
        return 'retrieve_fast_pick_up';
      case Exercises.retrieve_speed:
        return 'retrieve_speed';
      case Exercises.retrieve_delivery:
        return 'retrieve_delivery';
      case Exercises.retrieve_parking:
        return 'retrieve_parking';
      case Exercises.square:
        return 'square';
      case Exercises.recall:
        return 'recall';
      case Exercises.cones:
        return 'cones';
      case Exercises.hurdle:
        return 'hurdle';
      case Exercises.scent:
        return 'scent';
      default:
        throw FormatException('Invalid exercise value: $this');
    }
  }

  static Exercises fromJson(String json) {
    switch (json) {
      case 'motivation':
        return Exercises.motivation;
      case 'concentration':
        return Exercises.concentration;
      case 'excitement':
        return Exercises.excitement;
      case 'heelwork':
        return Exercises.heelwork;
      case 'heel_parking':
        return Exercises.heel_parking;
      case 'heel_angle':
        return Exercises.heel_angle;
      case 'heel_endurance':
        return Exercises.heel_endurance;
      case 'heel_speed_slow':
        return Exercises.heel_speed_slow;
      case 'heel_speed_normal':
        return Exercises.heel_speed_normal;
      case 'heel_speed_running':
        return Exercises.heel_speed_running;
      case 'group':
        return Exercises.group;
      case 'position_from_movement':
        return Exercises.position_from_movement;
      case 'distance_control':
        return Exercises.distance_control;
      case 'retrieve':
        return Exercises.retrieve;
      case 'retrieve_keep_calm':
        return Exercises.retrieve_keep_calm;
      case 'retrieve_fast_pick_up':
        return Exercises.retrieve_fast_pick_up;
      case 'retrieve_speed':
        return Exercises.retrieve_speed;
      case 'retrieve_delivery':
        return Exercises.retrieve_delivery;
      case 'retrieve_parking':
        return Exercises.retrieve_parking;
      case 'square':
        return Exercises.square;
      case 'recall':
        return Exercises.recall;
      case 'cones':
        return Exercises.cones;
      case 'hurdle':
        return Exercises.hurdle;
      case 'scent':
        return Exercises.scent;
      default:
        throw FormatException('Invalid exercise value: $json');
    }
  }
}

extension ExercisesRankingJsonExtension on Tuple<Exercises, double>{
  String toJson() {
    return '{"exercise": ${key.toJson()}, "rating": $value}';
  }

  static Tuple<Exercises, double> fromJson(String json) {
    final jsonMap = jsonDecode(json) as Map<String, dynamic>;
    return Tuple(ExercisesJsonExtension.fromJson(jsonMap['exercise'] as String), jsonMap['rating'] as double);
  }
}

extension ExercisesRankingListJsonExtension on List<Tuple<Exercises, double>>{
  String toJson() {
    return jsonEncode(this.map((e) => e.toJson()).toList());
  }

  static List<Tuple<Exercises, double>> fromJson(String json) {
    final jsonList = jsonDecode(json) as List<dynamic>;
    return jsonList.map((e) => ExercisesRankingJsonExtension.fromJson(e as String)).toList();
  }
}