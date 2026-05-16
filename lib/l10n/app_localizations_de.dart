// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hello, World!';

  @override
  String get buttonOk => 'Ok';

  @override
  String get buttonCancel => 'Abbrechen';

  @override
  String get buttonRestore => 'Wiederherstellen';

  @override
  String get appTitle => 'Hundesport Tagebuch';

  @override
  String get diary => 'Tagebuch';

  @override
  String get diaryEntry => 'Eintrag';

  @override
  String get dog => 'Hund';

  @override
  String get dogs => 'Hunde';

  @override
  String get name => 'Name';

  @override
  String get dateOfBirth => 'Geburtstag';

  @override
  String get weight => 'Gewicht';

  @override
  String get settings => 'Einstellungen';

  @override
  String get overview => 'Überblick';

  @override
  String get overviewLast28Days => 'Letzte 28 Tage';

  @override
  String get overviewNoDataLast28Days =>
      'Keine Trainingsdaten für die letzten 28 Tage';

  @override
  String get history => 'Verlauf';

  @override
  String get historyNoData => 'Keine Trainingsdaten vorhanden';

  @override
  String get dogPageAddDogs => 'Drücke + und füge einen Hund hinzu';

  @override
  String get diaryPageNoDogs => 'Du hast noch keine Hunde hinzugefügt';

  @override
  String get sportsMultiSelectionHint => 'Wähle Sportarten';

  @override
  String get general => 'Allgemein';

  @override
  String get date => 'Datum';

  @override
  String get minutes => 'min';

  @override
  String get temperature => 'Temperatur';

  @override
  String get trainingDuration => 'Trainingsdauer';

  @override
  String get warumUpDuration => 'Aufwärmdauer';

  @override
  String get coolDownDuration => 'Abwärmdauer';

  @override
  String get trainingGoal => 'Trainingsziel';

  @override
  String get trainingGoals => 'Trainingsziele';

  @override
  String get reachedTrainingGoals => 'Erreichte Trainingsziele';

  @override
  String get noTrainingGoalsTitle => 'Bleib am Training dran';

  @override
  String get noTrainingGoalsSubtitle => 'Du hast aktuell keine Ziele';

  @override
  String get highlight => 'Highlight';

  @override
  String get distractions => 'Schwierigkeiten';

  @override
  String get notes => 'Notizen';

  @override
  String get rating => 'Bewertung';

  @override
  String get ratingPlan => 'Planen';

  @override
  String get ratingPlanned => 'Geplant';

  @override
  String get opensourcepackages => 'Drittanbieterlizenzen';

  @override
  String get createBackup => 'Backup erstellen';

  @override
  String get restoreBackup => 'Backup wiederherstellen';

  @override
  String get backupSuccessful => 'Backup erfolgreich';

  @override
  String get backupCancelled => 'Backup wurde abgebrochen';

  @override
  String get backupFailed => 'Backup ist fehlgeschlagen';

  @override
  String get restoreSuccessful => 'Backup wiederhergestellt';

  @override
  String get restoreCancelled => 'Wiederherstellung abgebrochen';

  @override
  String get restoreFailed => 'Wiederherstellung fehlgeschlagen';

  @override
  String get restoreBackupHintText =>
      'Willst du das Backup wirklich wiederherstellen? Dies kann nicht rückgängig gemacht werden.';

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
        'other': 'Unbekannt',
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
        'other': 'Unbekannt',
      },
    );
    return '$_temp0';
  }

  @override
  String get exercise => 'Übung';

  @override
  String get count => 'Anzahl';

  @override
  String exercises(String exercise) {
    String _temp0 = intl.Intl.selectLogic(
      exercise,
      {
        'motivation': 'Motivation',
        'concentration': 'Konzentration',
        'excitement': 'Aufregung',
        'heelwork': 'Fußarbeit',
        'heelParking': 'Grundstellung',
        'heelAngle': 'Winkel',
        'heelEndurance': 'Ausdauertraining',
        'heelSpeedSlow': 'Langsamschritt',
        'heelSpeedNormal': 'Normalschritt',
        'heelSpeedFast': 'Laufschritt',
        'group': 'Gruppe',
        'positionFromMovement': 'Position aus der Bewegung',
        'distanceControl': 'Distanzkontrolle',
        'retrieve': 'Apport',
        'retrieveKeepCalm': 'Ruhiges Halten',
        'retrieveFastPickUp': 'Schnelle Aufnahme',
        'retrieveSpeed': 'Schneller Hin-/Rückweg',
        'retrieveDelivery': 'Abgabe',
        'retrieveParking': 'Einparken',
        'square': 'Box',
        'recall': 'Abrufen',
        'cones': 'Pylone',
        'hurdle': 'Hürde',
        'scent': 'Geruchsunterscheidung',
        'stand': 'Steh',
        'stop': 'Stop',
        'down': 'Platz',
        'sit': 'Sitz',
        'stay': 'Bleib',
        'turn': 'Kehrtwendung',
        'turnLeft': 'Links Kehrt',
        'turnRight': 'Rechts Kehrt',
        'sitInFront': 'Vorsitz',
        'slalom': 'Slalom',
        'eight': 'Acht',
        'goRound': 'HF Umrunden',
        'back': 'Zurück',
        'spiral': 'Spirale',
        'sidewards': 'Zur Seite',
        'twist': 'Kreis',
        'awall': 'Schrägwand',
        'hoop': 'Durchsprung',
        'broadJump': 'Weitsprung',
        'footbridge': 'Steg',
        'seesaw': 'Wippe',
        'tunnel': 'Tunnel',
        'other': 'Unbekannt',
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
        'oneYear': '1J',
        'other': 'Unbekannt',
      },
    );
    return '$_temp0';
  }
}
