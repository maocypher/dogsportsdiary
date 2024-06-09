import 'dart:convert';

import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

enum DogSports {
  agility,
  obedience,
  rallyo,
  ths
}

class Sports{
  static Map<DogSports, List<DogSportsClasses>> get sportsClasses => {
    DogSports.agility: [
      DogSportsClasses.A0,
      DogSportsClasses.A1,
      DogSportsClasses.A2,
      DogSportsClasses.A3,
      DogSportsClasses.AS,
      DogSportsClasses.JP0,
      DogSportsClasses.JP1,
      DogSportsClasses.JP2,
      DogSportsClasses.JP3,
      DogSportsClasses.JPS,
      DogSportsClasses.JPO
    ],
    DogSports.obedience: [
      DogSportsClasses.OB,
      DogSportsClasses.O1,
      DogSportsClasses.O2,
      DogSportsClasses.O3,
      DogSportsClasses.OS
    ],
    DogSports.rallyo: [
      DogSportsClasses.ROB,
      DogSportsClasses.RO1,
      DogSportsClasses.RO2,
      DogSportsClasses.RO3,
      DogSportsClasses.ROS
    ],
    DogSports.ths: [
      DogSportsClasses.VK1,
      DogSportsClasses.VK2,
      DogSportsClasses.VK3,
      DogSportsClasses.DK1,
      DogSportsClasses.DK2,
      DogSportsClasses.DK3,
      DogSportsClasses.CC
    ]
  };
  
  static Map<Tuple<DogSports, DogSportsClasses>, List<Exercises>> get sportsExercises => {
    Tuple(DogSports.obedience, DogSportsClasses.OB): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heel_parking,
      Exercises.heel_angle,
      Exercises.heel_speed_slow,
      Exercises.heel_speed_normal,
      Exercises.heel_speed_running,
      Exercises.group,
      Exercises.position_from_movement,
      Exercises.distance_control,
      Exercises.retrieve,
      Exercises.retrieve_keep_calm,
      Exercises.retrieve_fast_pick_up,
      Exercises.retrieve_speed,
      Exercises.retrieve_delivery,
      Exercises.retrieve_parking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
    ],
    Tuple(DogSports.obedience, DogSportsClasses.O1): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heel_parking,
      Exercises.heel_angle,
      Exercises.heel_speed_slow,
      Exercises.heel_speed_normal,
      Exercises.heel_speed_running,
      Exercises.group,
      Exercises.position_from_movement,
      Exercises.distance_control,
      Exercises.retrieve,
      Exercises.retrieve_keep_calm,
      Exercises.retrieve_fast_pick_up,
      Exercises.retrieve_speed,
      Exercises.retrieve_delivery,
      Exercises.retrieve_parking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
      Exercises.hurdle
    ],
    Tuple(DogSports.obedience, DogSportsClasses.O2): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heel_parking,
      Exercises.heel_angle,
      Exercises.heel_speed_slow,
      Exercises.heel_speed_normal,
      Exercises.heel_speed_running,
      Exercises.group,
      Exercises.position_from_movement,
      Exercises.distance_control,
      Exercises.retrieve,
      Exercises.retrieve_keep_calm,
      Exercises.retrieve_fast_pick_up,
      Exercises.retrieve_speed,
      Exercises.retrieve_delivery,
      Exercises.retrieve_parking,
      Exercises.square,
      Exercises.recall,
      Exercises.cones,
      Exercises.hurdle,
      Exercises.scent
    ],
    Tuple(DogSports.obedience, DogSportsClasses.O3): [
      Exercises.motivation,
      Exercises.concentration,
      Exercises.excitement,
      Exercises.heelwork,
      Exercises.heel_parking,
      Exercises.heel_angle,
      Exercises.heel_speed_slow,
      Exercises.heel_speed_normal,
      Exercises.heel_speed_running,
      Exercises.group,
      Exercises.position_from_movement,
      Exercises.distance_control,
      Exercises.retrieve,
      Exercises.retrieve_keep_calm,
      Exercises.retrieve_fast_pick_up,
      Exercises.retrieve_speed,
      Exercises.retrieve_delivery,
      Exercises.retrieve_parking,
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
    switch (this) {
      case DogSports.agility:
        return 'agility';
      case DogSports.obedience:
        return 'obedience';
      case DogSports.rallyo:
        return 'rallyo';
      case DogSports.ths:
        return 'ths';
      default:
        throw FormatException('Invalid dogsports value: $this');
    }
  }

  static DogSports fromJson(String json) {
    switch (json) {
      case 'agility':
        return DogSports.agility;
      case 'obedience':
        return DogSports.obedience;
      case 'rallyo':
        return DogSports.rallyo;
      case 'ths':
        return DogSports.ths;
      default:
        throw FormatException('Invalid dogsports value: $json');
    }
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
  String toJson() {
    return jsonEncode({'sport': key.toJson(), 'classes': value.toJson()});
  }

  static Tuple<DogSports, DogSportsClasses> fromJson(Map<String, dynamic> json) {
    return Tuple(DogSportsJsonExtension.fromJson(json['sport']), DogSportsClassesJsonExtension.fromJson(json['classes']));
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