import 'package:dog_sports_diary/features/home/home_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_dog/show_dog_tab.dart';

final routes = {
  '/': (context) => const HomeTab(label: 'Home'),
  '/dogs': (context) => const ShowDogTab(label: 'Dogs'),
  '/diary': (context) => const ShowDiaryEntryTab(label: 'Diary'),
  '/settings': (context) => const SettingsTab(label: 'Settings'),
};