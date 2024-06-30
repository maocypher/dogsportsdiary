import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/navigation/dog_navigation_observer.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/scaffold_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorDogKey = GlobalKey<NavigatorState>(debugLabel: 'shellDogTab');
  static final _shellNavigatorDiaryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDiaryTab');
  static final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettingsTab');

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static GlobalKey<NavigatorState> get shellNavigatorDogKey => _shellNavigatorDogKey;
  static GlobalKey<NavigatorState> get shellNavigatorDiaryKey => _shellNavigatorDiaryKey;
  static GlobalKey<NavigatorState> get shellNavigatorSettingsKey => _shellNavigatorSettingsKey;

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/diary',
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
            navigatorKey: _shellNavigatorDiaryKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/diary',
                name: 'diary',
                pageBuilder: (context, state) => NoTransitionPage(
                  name: "diary",
                  child: ShowDiaryEntryTab(showDiaryEntryViewmodel: ServiceProvider.locator<ShowDiaryEntryViewmodel>()),
                ),
                routes: [
                  GoRoute(
                    path: 'new-entry',
                    name: 'new-entry',
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: "new-entry",
                      child: DiaryEntryTab(
                        diaryEntryViewModel: ServiceProvider.locator<DiaryEntryViewModel>(),
                        label: 'Diary Entry',
                      ),
                    ),
                  ),
                  GoRoute(
                    path: ':entryKey',
                    name: 'edit-entry',
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: "edit-entry",
                      child: DiaryEntryTab(
                        diaryEntryViewModel: ServiceProvider.locator<DiaryEntryViewModel>(param1: state.pathParameters['entryKey']),
                        label: 'Diary Entry',
                      ),
                    ),
                  ),
                ]
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
                  GoRoute(
                    path: ':name',
                    name: 'edit-dog',
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: "edit-dog",
                      child: DogTab(
                        dogViewModel: ServiceProvider.locator<DogViewModel>(param1: state.pathParameters['name']),
                        label: 'Dog',
                      ),
                    ),
                  ),
                ],
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