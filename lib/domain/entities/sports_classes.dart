enum DogSportsClasses {
  //Agility
  A0,
  A1,
  A2,
  A3,
  AS,
  //Jumping
  JP0,
  JP1,
  JP2,
  JP3,
  JPS,
  JPO,
  //Obedience
  OB,
  O1,
  O2,
  O3,
  OS,
  //Rally-Obedience
  ROB,
  RO1,
  RO2,
  RO3,
  ROS,
  //THS - VK
  VK1,
  VK2,
  VK3,
  //THS - DK
  DK1,
  DK2,
  DK3,
  //Canicross
  CC
}

extension DogSportsClassesJsonExtension on DogSportsClasses {
  String toJson() {
    switch (this) {
      case DogSportsClasses.A0:
        return 'A0';
      case DogSportsClasses.A1:
        return 'A1';
      case DogSportsClasses.A2:
        return 'A2';
      case DogSportsClasses.A3:
        return 'A3';
      case DogSportsClasses.AS:
        return 'AS';
      case DogSportsClasses.JP0:
        return 'JP0';
      case DogSportsClasses.JP1:
        return 'JP1';
      case DogSportsClasses.JP2:
        return 'JP2';
      case DogSportsClasses.JP3:
        return 'JP3';
      case DogSportsClasses.JPS:
        return 'JPS';
      case DogSportsClasses.JPO:
        return 'JPO';
      case DogSportsClasses.OB:
        return 'OB';
      case DogSportsClasses.O1:
        return 'O1';
      case DogSportsClasses.O2:
        return 'O2';
      case DogSportsClasses.O3:
        return 'O3';
      case DogSportsClasses.OS:
        return 'OS';
      case DogSportsClasses.ROB:
        return 'ROB';
      case DogSportsClasses.RO1:
        return 'RO1';
      case DogSportsClasses.RO2:
        return 'RO2';
      case DogSportsClasses.RO3:
        return 'RO3';
      case DogSportsClasses.ROS:
        return 'ROS';
      case DogSportsClasses.VK1:
        return 'VK1';
      case DogSportsClasses.VK2:
        return 'VK2';
      case DogSportsClasses.VK3:
        return 'VK3';
      case DogSportsClasses.DK1:
        return 'DK1';
      case DogSportsClasses.DK2:
        return 'DK2';
      case DogSportsClasses.DK3:
        return 'DK3';
      case DogSportsClasses.CC:
        return 'CC';
      default:
        throw FormatException('Invalid ranking value: $this');
    }
  }

  static DogSportsClasses fromJson(String json) {
    switch (json) {
      case 'A0':
        return DogSportsClasses.A0;
      case 'A1':
        return DogSportsClasses.A1;
      case 'A2':
        return DogSportsClasses.A2;
      case 'A3':
        return DogSportsClasses.A3;
      case 'AS':
        return DogSportsClasses.AS;
      case 'JP0':
        return DogSportsClasses.JP0;
      case 'JP1':
        return DogSportsClasses.JP1;
      case 'JP2':
        return DogSportsClasses.JP2;
      case 'JP3':
        return DogSportsClasses.JP3;
      case 'JPS':
        return DogSportsClasses.JPS;
      case 'JPO':
        return DogSportsClasses.JPO;
      case 'OB':
        return DogSportsClasses.OB;
      case 'O1':
        return DogSportsClasses.O1;
      case 'O2':
        return DogSportsClasses.O2;
      case 'O3':
        return DogSportsClasses.O3;
      case 'OS':
        return DogSportsClasses.OS;
      case 'ROB':
        return DogSportsClasses.ROB;
      case 'RO1':
        return DogSportsClasses.RO1;
      case 'RO2':
        return DogSportsClasses.RO2;
      case 'RO3':
        return DogSportsClasses.RO3;
      case 'ROS':
        return DogSportsClasses.ROS;
      case 'VK1':
        return DogSportsClasses.VK1;
      case 'VK2':
        return DogSportsClasses.VK2;
      case 'VK3':
        return DogSportsClasses.VK3;
      case 'DK1':
        return DogSportsClasses.DK1;
      case 'DK2':
        return DogSportsClasses.DK2;
      case 'DK3':
        return DogSportsClasses.DK3;
      case 'CC':
        return DogSportsClasses.CC;
      default:
        throw FormatException('Invalid ranking value: $json');
    }
  }
}