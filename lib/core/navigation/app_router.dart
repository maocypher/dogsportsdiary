import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/navigation/dog_navigation_observer.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dog_sports_diary/features/home/home_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/scaffold_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHomeTab');
  static final _shellNavigatorDogKey = GlobalKey<NavigatorState>(debugLabel: 'shellDogTab');
  static final _shellNavigatorDiaryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDiaryTab');
  static final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettingsTab');

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static GlobalKey<NavigatorState> get shellNavigatorHomeKey => _shellNavigatorHomeKey;
  static GlobalKey<NavigatorState> get shellNavigatorDogKey => _shellNavigatorDogKey;
  static GlobalKey<NavigatorState> get shellNavigatorDiaryKey => _shellNavigatorDiaryKey;
  static GlobalKey<NavigatorState> get shellNavigatorSettingsKey => _shellNavigatorSettingsKey;

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Stateful nested navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell);
        },
        branches: [
          // first branch (A)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/',
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: "home",
                  child: HomeTab(label: 'Home'),
                ),
              ),
            ],
          ),
          // second branch (B)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDogKey,
            observers: [DogNavigationObserver(showDogsViewModel: ServiceProvider.locator<ShowDogsViewModel>())],
            routes: [
              // top route inside branch
              GoRoute(
                path: '/dog',
                name: 'dogs',
                pageBuilder: (context, state) => NoTransitionPage(
                  name: "dogs",
                  child: ShowDogsTab(
                    showDogViewModel: ServiceProvider.locator<ShowDogsViewModel>(),
                    label: 'Dogs',
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'new-dog',
                    name: 'new-dog',
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: "new-dog",
                      child: DogTab(
                        dogViewModel: ServiceProvider.locator<DogViewModel>(),
                        label: 'Dog',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDiaryKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/diary',
                name: 'diary',
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: "diary",
                  child: ShowDiaryEntryTab(label: 'Diary'),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/settings',
                name: 'settings',
                pageBuilder: (context, state) => NoTransitionPage(
                  name: "settings",
                  child: SettingsTab(
                      settingsViewModel: ServiceProvider.locator<SettingsViewModel>(),
                      label: 'Settings'
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}