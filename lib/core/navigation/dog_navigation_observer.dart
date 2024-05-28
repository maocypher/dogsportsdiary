import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class DogNavigationObserver extends NavigatorObserver {

  final log = Logger('MyNavObserver');
  final ShowDogsViewModel showDogsViewModel;

  DogNavigationObserver({required this.showDogsViewModel}) {
    log.onRecord.listen((e) => debugPrint('$e'));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.info('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute){
    log.info('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

    if(previousRoute?.settings.name == 'dogs') {
      showDogsViewModel.loadDogs();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.info('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log.info('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
      Route<dynamic> route,
      Route<dynamic>? previousRoute,
      ) =>
      log.info('didStartUserGesture: ${route.str}, '
          'previousRoute= ${previousRoute?.str}');

  @override
  void didStopUserGesture() => log.info('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name})';
}