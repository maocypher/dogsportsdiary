enum DogSportsClasses {
  agilityA0,
  agilityA1,
  agilityA2,
  agilityA3,
  agilityAS,
  jumpingJP0,
  jumpingJP1,
  jumpingJP2,
  jumpingJP3,
  jumpingJPS,
  jumpingJPO,
  obedienceOB,
  obedienceO1,
  obedienceO2,
  obedienceO3,
  obedienceOS,
  rallyObedienceROB,
  rallyObedienceRO1,
  rallyObedienceRO2,
  rallyObedienceRO3,
  rallyObedienceROS,
  thsVK1,
  thsVK2,
  thsVK3,
  thsDK1,
  thsDK2,
  thsDK3,
  canicross;

  @override
  String toString() {
    return SportClassConstants.sportClassToJson[this]!;
  }
}

class SportClassConstants {
  static const Map<DogSportsClasses, String> sportClassToJson = {
    DogSportsClasses.agilityA0: 'A0',
    DogSportsClasses.agilityA1: 'A1',
    DogSportsClasses.agilityA2: 'A2',
    DogSportsClasses.agilityA3: 'A3',
    DogSportsClasses.agilityAS: 'AS',
    DogSportsClasses.jumpingJP0: 'JP0',
    DogSportsClasses.jumpingJP1: 'JP1',
    DogSportsClasses.jumpingJP2: 'JP2',
    DogSportsClasses.jumpingJP3: 'JP3',
    DogSportsClasses.jumpingJPS: 'JPS',
    DogSportsClasses.jumpingJPO: 'JPO',
    DogSportsClasses.obedienceOB: 'OB',
    DogSportsClasses.obedienceO1: 'O1',
    DogSportsClasses.obedienceO2: 'O2',
    DogSportsClasses.obedienceO3: 'O3',
    DogSportsClasses.obedienceOS: 'OS',
    DogSportsClasses.rallyObedienceROB: 'ROB',
    DogSportsClasses.rallyObedienceRO1: 'RO1',
    DogSportsClasses.rallyObedienceRO2: 'RO2',
    DogSportsClasses.rallyObedienceRO3: 'RO3',
    DogSportsClasses.rallyObedienceROS: 'ROS',
    DogSportsClasses.thsVK1: 'VK1',
    DogSportsClasses.thsVK2: 'VK2',
    DogSportsClasses.thsVK3: 'VK3',
    DogSportsClasses.thsDK1: 'DK1',
    DogSportsClasses.thsDK2: 'DK2',
    DogSportsClasses.thsDK3: 'DK3',
    DogSportsClasses.canicross: 'CC',
  };

  static Map<String, DogSportsClasses> jsonToSportClass = Map.fromEntries(sportClassToJson.entries.map((e) => MapEntry(e.value, e.key)));
}

extension DogSportsClassesJsonExtension on DogSportsClasses {
  String toJson() => SportClassConstants.sportClassToJson[this]!;

  static DogSportsClasses fromJson(String json) =>
      SportClassConstants.jsonToSportClass[json]!;
}