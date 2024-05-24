import 'package:dog_sports_diary/features/home/home_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_dog/show_dog_tab.dart';
import 'package:dog_sports_diary/presentation/widgets/scaffold_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHomeTab');
final _shellNavigatorDogKey = GlobalKey<NavigatorState>(debugLabel: 'shellDogTab');
final _shellNavigatorDiaryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDiaryTab');
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettingsTab');

final GoRouter router = GoRouter(
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
              path: '/dogs',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ShowDogTab(label: 'Dogs',),
              ),
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
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsTab(label: 'Settings'),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

//ShellRoute(
//       routes: [
//         GoRoute(
//           path: '/',
//           name: 'home',
//           builder: (context, state) => const HomeTab(),
//         ),
//         GoRoute(
//           path: '/dogs',
//           name: 'dogs',
//           builder: (context, state) => const ShowDogTab(),
//         ),
//         GoRoute(
//           path: '/diary',
//           name: 'diary',
//           builder: (context, state) => const ShowDiaryEntryTab(),
//         ),
//         GoRoute(
//           path: '/settings',
//           name: 'settings',
//           builder: (context, state) => const SettingsTab(),
//         ),
//       ],
//     ),