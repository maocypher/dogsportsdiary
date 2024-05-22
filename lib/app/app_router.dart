import 'package:dog_sports_diary/features/home/home_page.dart';
import 'package:dog_sports_diary/features/settings/settings_page.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_page.dart';
import 'package:dog_sports_diary/features/show_dog/show_dog_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/dogs',
      name: 'dogs',
      builder: (context, state) => const ShowDogPage(),
    ),
    GoRoute(
      path: '/diary',
      name: 'diary',
      builder: (context, state) => const ShowDiaryEntryPage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);