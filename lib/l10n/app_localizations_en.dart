// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get buttonOk => 'Ok';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonRestore => 'Restore';

  @override
  String get appTitle => 'Dog sports diary';

  @override
  String get diary => 'Diary';

  @override
  String get diaryEntry => 'Diary entry';

  @override
  String get dog => 'Dog';

  @override
  String get dogs => 'Dogs';

  @override
  String get name => 'Name';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get weight => 'Weight';

  @override
  String get settings => 'Settings';

  @override
  String get overview => 'Overview';

  @override
  String get overviewLast28Days => 'Last 28 days';

  @override
  String get overviewNoDataLast28Days => 'No training data for last 28 days';

  @override
  String get history => 'History';

  @override
  String get historyNoData => 'No training data';

  @override
  String get dogPageAddDogs => 'Press the + button to add a dog';

  @override
  String get diaryPageNoDogs => 'You have no dogs added yet';

  @override
  String get sportsMultiSelectionHint => 'Select sports';

  @override
  String get general => 'General information';

  @override
  String get date => 'Date';

  @override
  String get minutes => 'min';

  @override
  String get temperature => 'Temperature';

  @override
  String get trainingDuration => 'Training Duration';

  @override
  String get warumUpDuration => 'Warm-up Duration';

  @override
  String get coolDownDuration => 'Cool-down Duration';

  @override
  String get trainingGoal => 'Training goal';

  @override
  String get trainingGoals => 'Training goals';

  @override
  String get reachedTrainingGoals => 'Reached training goals';

  @override
  String get noTrainingGoalsTitle => 'Keep up the training';

  @override
  String get noTrainingGoalsSubtitle => 'You don\'t have any goals currently';

  @override
  String get highlight => 'Highlight';

  @override
  String get distractions => 'Distractions';

  @override
  String get notes => 'Notes';

  @override
  String get rating => 'Rating';

  @override
  String get ratingPlan => 'Plan';

  @override
  String get ratingPlanned => 'Planned';

  @override
  String get opensourcepackages => 'Third party licenses';

  @override
  String get createBackup => 'Create backup';

  @override
  String get restoreBackup => 'Restore backup';

  @override
  String get backupSuccessful => 'Backup successful';

  @override
  String get backupCancelled => 'Backup cancelled';

  @override
  String get backupFailed => 'Backup failed';

  @override
  String get restoreSuccessful => 'Backup restored';

  @override
  String get restoreCancelled => 'Restore cancelled';

  @override
  String get restoreFailed => 'Restore failed';

  @override
  String get restoreBackupHintText =>
      'Are you sure you want to restore the backup? This is irreversible.';

  @override
  String dogSports(String sport) {
    String _temp0 = intl.Intl.selectLogic(
      sport,
      {
        'agility': 'Agility',
        'jumping': 'Jumping',
        'obedience': 'Obedience',
        'rallyo': 'Rally-O',
        'rallyObedience': 'Rally-O',
        'thsVk': 'THS VK',
        'thsDk': 'THS DK',
        'cc': 'Canicross',
        'other': 'unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String dogSportsClasses(String classes) {
    String _temp0 = intl.Intl.selectLogic(
      classes,
      {
        'A0': 'Agility A0',
        'A1': 'Agility A1',
        'A2': 'Agility A2',
        'A3': 'Agility A3',
        'AS': 'Agility AS',
        'JP0': 'Jumping JP0',
        'JP1': 'Jumping JP1',
        'JP2': 'Jumping JP2',
        'JP3': 'Jumping JP3',
        'JPS': 'Jumping JPS',
        'OB': 'Obedience Beginner',
        'O1': 'Obedience 1',
        'O2': 'Obedience 2',
        'O3': 'Obedience 3',
        'OS': 'Obedience Senior',
        'ROB': 'Rally-O Beginner',
        'RO1': 'Rally-O 1',
        'RO2': 'Rally-O 2',
        'RO3': 'Rally-O 3',
        'ROS': 'Rally-O Senior',
        'VK1': 'THS VK1',
        'VK2': 'THS VK2',
        'VK3': 'THS VK3',
        'DK1': 'THS DK1',
        'DK2': 'THS DK2',
        'DK3': 'THS DK3',
        'CC': 'Canicross',
        'other': 'unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get exercise => 'Exercise';

  @override
  String get count => 'Count';

  @override
  String exercises(String exercise) {
    String _temp0 = intl.Intl.selectLogic(
      exercise,
      {
        'motivation': 'Motivation',
        'concentration': 'Concentration',
        'excitement': 'Excitement',
        'heelwork': 'Heelwork',
        'heelParking': 'Close',
        'heelAngle': 'Angle',
        'heelEndurance': 'Endurance',
        'heelSpeedSlow': 'Slow HW',
        'heelSpeedNormal': 'Normale HW',
        'heelSpeedFast': 'Fast HW',
        'group': 'Group',
        'positionFromMovement': 'Position from movement',
        'distanceControl': 'Distance control',
        'retrieve': 'Retrieve',
        'retrieveKeepCalm': 'Hold still',
        'retrieveFastPickUp': 'Fast pick up',
        'retrieveSpeed': 'Fast outward/return',
        'retrieveDelivery': 'Delivery',
        'retrieveParking': 'Parking',
        'square': 'Square',
        'recall': 'Recall',
        'cones': 'Cones',
        'hurdle': 'Hurdle',
        'scent': 'Scent distinction',
        'stand': 'Stand',
        'stop': 'Stop',
        'down': 'Down',
        'sit': 'Sit',
        'stay': 'Stay',
        'turn': 'Turn',
        'turnLeft': 'Turn left',
        'turnRight': 'Turn right',
        'sitInFront': 'Sit in front',
        'slalom': 'Slalom',
        'eight': 'Eight',
        'goRound': 'Go around DG',
        'back': 'Back',
        'spiral': 'Spirale',
        'sidewards': 'Sidewards',
        'twist': 'Twist',
        'awall': 'Slanted wall',
        'hoop': 'Hoop',
        'broadJump': 'Broad jump',
        'footbridge': 'Footbridge',
        'seesaw': 'Seesaw',
        'tunnel': 'Tunnel',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String historyRange(String range) {
    String _temp0 = intl.Intl.selectLogic(
      range,
      {
        'fourWeeks': '4W',
        'threeMonths': '3M',
        'sixMonths': '6M',
        'oneYear': '1Y',
        'other': 'Unbekannt',
      },
    );
    return '$_temp0';
  }
}
