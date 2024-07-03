import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/navigation/diary_entry_navigation_observer.dart';
import 'package:dog_sports_diary/core/navigation/dog_navigation_observer.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/scaffold_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    initialLocation: Constants.routeDiary,
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
            observers: [
              DiaryEntryNavigationObserver(showDiaryEntryViewModel: ServiceProvider.locator<ShowDiaryEntryViewmodel>()),
              DogNavigationObserver(showDogsViewModel: ServiceProvider.locator<ShowDogsViewModel>())
            ],
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeDiary,
                name: Constants.diary,
                pageBuilder: (context, state) => NoTransitionPage(
                  name: Constants.diary,
                  child: ShowDiaryEntryTab(
                      showDiaryEntryViewmodel: ServiceProvider.locator<ShowDiaryEntryViewmodel>(),
                      label: AppLocalizations.of(context)!.diary,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: Constants.routeDiaryNew,
                    name: Constants.routeDiaryNew,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDiaryNew,
                      child: DiaryEntryTab(
                        diaryEntryViewModel: ServiceProvider.locator<DiaryEntryViewModel>(),
                        label: AppLocalizations.of(context)!.diaryEntry,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: ':entryKey',
                    name: Constants.routeDiaryEdit,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDiaryEdit,
                      child: DiaryEntryTab(
                        diaryEntryViewModel: ServiceProvider.locator<DiaryEntryViewModel>(param1: state.pathParameters['entryKey']),
                        label: AppLocalizations.of(context)!.diaryEntry,
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
                path: Constants.routeDog,
                name: Constants.dogs,
                pageBuilder: (context, state) => NoTransitionPage(
                  name: Constants.dogs,
                  child: ShowDogsTab(
                    showDogViewModel: ServiceProvider.locator<ShowDogsViewModel>(),
                    label: AppLocalizations.of(context)!.dogs,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: Constants.routeDogNew,
                    name: Constants.routeDogNew,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDogNew,
                      child: DogTab(
                        dogViewModel: ServiceProvider.locator<DogViewModel>(),
                        label: AppLocalizations.of(context)!.dog,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: ':name',
                    name: Constants.routeDogEdit,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: Constants.routeDogEdit,
                      child: DogTab(
                        dogViewModel: ServiceProvider.locator<DogViewModel>(param1: state.pathParameters['name']),
                        label: AppLocalizations.of(context)!.dog,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: Constants.routeSettings,
                name: Constants.settings,
                pageBuilder: (context, state) => NoTransitionPage(
                  name: Constants.settings,
                  child: SettingsTab(
                      settingsViewModel: ServiceProvider.locator<SettingsViewModel>(),
                      label: AppLocalizations.of(context)!.settings
                  ),
                ),
              ),
            ],
          ),*/
        ],
      ),
    ],
  );
}