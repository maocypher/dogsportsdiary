import 'package:dog_sports_diary/core/navigation/diary_entry_navigation_observer.dart';
import 'package:dog_sports_diary/core/navigation/dog_navigation_observer.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/history/history_tab.dart';
import 'package:dog_sports_diary/features/overview/overview_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/presentation/widgets/scaffold_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorDogKey = GlobalKey<NavigatorState>(debugLabel: 'shellDogTab');
  static final _shellNavigatorDiaryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDiaryTab');
  static final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettingsTab');
  static final _shellNavigatorOverviewKey = GlobalKey<NavigatorState>(debugLabel: 'shellOverviewTab');

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static GlobalKey<NavigatorState> get shellNavigatorDogKey => _shellNavigatorDogKey;
  static GlobalKey<NavigatorState> get shellNavigatorDiaryKey => _shellNavigatorDiaryKey;
  static GlobalKey<NavigatorState> get shellNavigatorSettingsKey => _shellNavigatorSettingsKey;
  static GlobalKey<NavigatorState> get shellNavigatorOverviewKey => _shellNavigatorOverviewKey;

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Constants.routeOverview,
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
          //Overview
          StatefulShellBranch(
            navigatorKey: _shellNavigatorOverviewKey,
            observers: [
              DogNavigationObserver()
            ],
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeOverview,
                name: Constants.overview,
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: Constants.overview,
                  child: OverviewTab(),
                ),
                routes: [
                  GoRoute(
                    path: ':dogId/history/:exerciseId',
                    name: Constants.routeOverviewHistory,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeOverviewHistory,
                      child: HistoryTab(dogIdStr: state.pathParameters['dogId'], exerciseIdStr: state.pathParameters['exerciseId']),
                    ),
                  ),
                ]
              ),
            ],
          ),

          //Diary
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDiaryKey,
            observers: [
              DiaryEntryNavigationObserver(),
              DogNavigationObserver()
            ],
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeDiary,
                name: Constants.diary,
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: Constants.diary,
                  child: ShowDiaryEntryTab(),
                ),
                routes: [
                  GoRoute(
                    path: Constants.routeDiaryNew,
                    name: Constants.routeDiaryNew,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      name: Constants.routeDiaryNew,
                      child: DiaryEntryTab(),
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    name: Constants.routeDiaryEdit,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDiaryEdit,
                      child: DiaryEntryTab(idStr: state.pathParameters['id']),
                    ),
                  ),
                ]
              ),
            ],
          ),

          //Dogs
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDogKey,
            observers: [DogNavigationObserver()],
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeDog,
                name: Constants.dogs,
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: Constants.dogs,
                  child: ShowDogsTab(),
                ),
                routes: [
                  GoRoute(
                    path: Constants.routeDogNew,
                    name: Constants.routeDogNew,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      name: Constants.routeDogNew,
                      child: DogTab(),
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    name: Constants.routeDogEdit,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDogEdit,
                      child: DogTab(idStr: state.pathParameters['id']),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Settings
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeSettings,
                name: Constants.settings,
                pageBuilder: (context, state) => const NoTransitionPage(
                  name: Constants.settings,
                  child: SettingsTab(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}