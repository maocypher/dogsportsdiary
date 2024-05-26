import 'package:dog_sports_diary/core/di/serivce_provider.dart';
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
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeTab(label: 'Home'),
                ),
              ),
            ],
          ),
          // second branch (B)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDogKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/dog',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: ShowDogsTab(
                    showDogViewModel: ServiceProvider.locator<ShowDogsViewModel>(),
                    label: 'Dogs',
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'new-dog',
                    pageBuilder: (context, state) => NoTransitionPage(
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
                pageBuilder: (context, state) => const NoTransitionPage(
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
                pageBuilder: (context, state) => NoTransitionPage(
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