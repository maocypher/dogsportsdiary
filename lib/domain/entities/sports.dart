enum Sports {
  agility,
  obedience,
  rallyo,
  ths
}

extension SportsJsonExtension on Sports {
  String toJson() {
    switch (this) {
      case Sports.agility:
        return 'agility';
      case Sports.obedience:
        return 'obedience';
      case Sports.rallyo:
        return 'rallyo';
      case Sports.ths:
        return 'ths';
      default:
        throw FormatException('Invalid ranking value: $this');
    }
  }
  
  static Sports fromJson(String json) {
    switch (json) {
      case 'agility':
        return Sports.agility;
      case 'obedience':
        return Sports.obedience;
      case 'rallyo':
        return Sports.rallyo;
      case 'ths':
        return Sports.ths;
      default:
        throw FormatException('Invalid ranking value: $json');
    }
  }
}