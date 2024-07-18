import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DiaryEntryNavigationObserver extends NavigatorObserver {

  final log = Logger();
  final ShowDiaryEntryViewmodel showDiaryEntryViewModel = ShowDiaryEntryViewmodel.showDiaryEntryViewModel;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.i('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute){
    log.i('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

    if(previousRoute?.settings.name == Constants.diary) {
      showDiaryEntryViewModel.loadDiaryEntriesAsync();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.i('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log.i('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
      Route<dynamic> route,
      Route<dynamic>? previousRoute,
      ) =>
      log.i('didStartUserGesture: ${route.str}, '
          'previousRoute= ${previousRoute?.str}');

  @override
  void didStopUserGesture() => log.i('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name})';
}