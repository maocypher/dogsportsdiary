import 'package:dog_sports_diary/domain/entities/sports_classes.dart';

enum DogSports {
  agility,
  obedience,
  rallyo,
  ths
}

class Sports{
  static Map<DogSports, List<DogSportsClasses>> get sportsClasses => {
    DogSports.agility: [DogSportsClasses.A0, DogSportsClasses.A1, DogSportsClasses.A2, DogSportsClasses.A3, DogSportsClasses.AS, DogSportsClasses.JP0, DogSportsClasses.JP1, DogSportsClasses.JP2, DogSportsClasses.JP3, DogSportsClasses.JPS, DogSportsClasses.JPO],
    DogSports.obedience: [DogSportsClasses.OB, DogSportsClasses.O1, DogSportsClasses.O2, DogSportsClasses.O3, DogSportsClasses.OS],
    DogSports.rallyo: [DogSportsClasses.ROB, DogSportsClasses.RO1, DogSportsClasses.RO2, DogSportsClasses.RO3, DogSportsClasses.ROS],
    DogSports.ths: [DogSportsClasses.VK1, DogSportsClasses.VK2, DogSportsClasses.VK3, DogSportsClasses.DK1, DogSportsClasses.DK2, DogSportsClasses.DK3, DogSportsClasses.CC]
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
        throw FormatException('Invalid ranking value: $this');
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
        throw FormatException('Invalid ranking value: $json');
    }
  }
}