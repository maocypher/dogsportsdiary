import 'package:dog_sports_diary/features/home/home_page.dart';
import 'package:dog_sports_diary/features/settings/settings_page.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_page.dart';
import 'package:dog_sports_diary/features/show_dog/show_dog_page.dart';

final routes = {
  '/': (context) => const HomePage(),
  '/dogs': (context) => const ShowDogPage(),
  '/diary': (context) => const ShowDiaryEntryPage(),
  '/settings': (context) => const SettingsPage(),
};