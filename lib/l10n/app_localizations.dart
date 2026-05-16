import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @buttonOk.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get buttonOk;

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// No description provided for @buttonRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get buttonRestore;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dog sports diary'**
  String get appTitle;

  /// No description provided for @diary.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get diary;

  /// No description provided for @diaryEntry.
  ///
  /// In en, this message translates to:
  /// **'Diary entry'**
  String get diaryEntry;

  /// No description provided for @dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get dog;

  /// No description provided for @dogs.
  ///
  /// In en, this message translates to:
  /// **'Dogs'**
  String get dogs;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @overviewLast28Days.
  ///
  /// In en, this message translates to:
  /// **'Last 28 days'**
  String get overviewLast28Days;

  /// No description provided for @overviewNoDataLast28Days.
  ///
  /// In en, this message translates to:
  /// **'No training data for last 28 days'**
  String get overviewNoDataLast28Days;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @historyNoData.
  ///
  /// In en, this message translates to:
  /// **'No training data'**
  String get historyNoData;

  /// No description provided for @dogPageAddDogs.
  ///
  /// In en, this message translates to:
  /// **'Press the + button to add a dog'**
  String get dogPageAddDogs;

  /// No description provided for @diaryPageNoDogs.
  ///
  /// In en, this message translates to:
  /// **'You have no dogs added yet'**
  String get diaryPageNoDogs;

  /// No description provided for @sportsMultiSelectionHint.
  ///
  /// In en, this message translates to:
  /// **'Select sports'**
  String get sportsMultiSelectionHint;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General information'**
  String get general;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @trainingDuration.
  ///
  /// In en, this message translates to:
  /// **'Training Duration'**
  String get trainingDuration;

  /// No description provided for @warumUpDuration.
  ///
  /// In en, this message translates to:
  /// **'Warm-up Duration'**
  String get warumUpDuration;

  /// No description provided for @coolDownDuration.
  ///
  /// In en, this message translates to:
  /// **'Cool-down Duration'**
  String get coolDownDuration;

  /// No description provided for @trainingGoal.
  ///
  /// In en, this message translates to:
  /// **'Training goal'**
  String get trainingGoal;

  /// No description provided for @trainingGoals.
  ///
  /// In en, this message translates to:
  /// **'Training goals'**
  String get trainingGoals;

  /// No description provided for @reachedTrainingGoals.
  ///
  /// In en, this message translates to:
  /// **'Reached training goals'**
  String get reachedTrainingGoals;

  /// No description provided for @noTrainingGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep up the training'**
  String get noTrainingGoalsTitle;

  /// No description provided for @noTrainingGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any goals currently'**
  String get noTrainingGoalsSubtitle;

  /// No description provided for @highlight.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get highlight;

  /// No description provided for @distractions.
  ///
  /// In en, this message translates to:
  /// **'Distractions'**
  String get distractions;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @ratingPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get ratingPlan;

  /// No description provided for @ratingPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get ratingPlanned;

  /// No description provided for @opensourcepackages.
  ///
  /// In en, this message translates to:
  /// **'Third party licenses'**
  String get opensourcepackages;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create backup'**
  String get createBackup;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get restoreBackup;

  /// No description provided for @backupSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Backup successful'**
  String get backupSuccessful;

  /// No description provided for @backupCancelled.
  ///
  /// In en, this message translates to:
  /// **'Backup cancelled'**
  String get backupCancelled;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed'**
  String get backupFailed;

  /// No description provided for @restoreSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Backup restored'**
  String get restoreSuccessful;

  /// No description provided for @restoreCancelled.
  ///
  /// In en, this message translates to:
  /// **'Restore cancelled'**
  String get restoreCancelled;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed'**
  String get restoreFailed;

  /// No description provided for @restoreBackupHintText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to restore the backup? This is irreversible.'**
  String get restoreBackupHintText;

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{sport, select, agility{Agility} jumping{Jumping} obedience{Obedience} rallyo{Rally-O} rallyObedience{Rally-O} thsVk{THS VK} thsDk{THS DK} cc{Canicross} other{unknown}}'**
  String dogSports(String sport);

  /// Translation for dog sport class
  ///
  /// In en, this message translates to:
  /// **'{classes, select, A0{Agility A0} A1{Agility A1} A2{Agility A2} A3{Agility A3} AS{Agility AS} JP0{Jumping JP0} JP1{Jumping JP1} JP2{Jumping JP2} JP3{Jumping JP3} JPS{Jumping JPS} OB{Obedience Beginner} O1{Obedience 1} O2{Obedience 2} O3{Obedience 3} OS{Obedience Senior} ROB{Rally-O Beginner} RO1{Rally-O 1} RO2{Rally-O 2} RO3{Rally-O 3} ROS{Rally-O Senior} VK1{THS VK1} VK2{THS VK2} VK3{THS VK3} DK1{THS DK1} DK2{THS DK2} DK3{THS DK3} CC{Canicross} other{unknown}}'**
  String dogSportsClasses(String classes);

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// Translation for exercises
  ///
  /// In en, this message translates to:
  /// **'{exercise, select, motivation{Motivation} concentration{Concentration} excitement{Excitement} heelwork{Heelwork} heelParking{Close} heelAngle{Angle} heelEndurance{Endurance} heelSpeedSlow{Slow HW} heelSpeedNormal{Normale HW} heelSpeedFast{Fast HW} group{Group} positionFromMovement{Position from movement} distanceControl{Distance control} retrieve{Retrieve} retrieveKeepCalm{Hold still} retrieveFastPickUp{Fast pick up} retrieveSpeed{Fast outward/return} retrieveDelivery{Delivery} retrieveParking{Parking} square{Square} recall{Recall} cones{Cones} hurdle{Hurdle} scent{Scent distinction} stand{Stand}  stop{Stop} down{Down} sit{Sit} stay{Stay} turn{Turn} turnLeft{Turn left} turnRight{Turn right} sitInFront{Sit in front} slalom{Slalom} eight{Eight} goRound{Go around DG} back{Back} spiral{Spirale} sidewards{Sidewards} twist{Twist} awall{Slanted wall} hoop{Hoop} broadJump{Broad jump} footbridge{Footbridge} seesaw{Seesaw} tunnel{Tunnel} other{Other}}'**
  String exercises(String exercise);

  /// Translation for history range
  ///
  /// In en, this message translates to:
  /// **'{range, select, fourWeeks{4W} threeMonths{3M} sixMonths{6M} oneYear{1Y} other{Unbekannt}}'**
  String historyRange(String range);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
