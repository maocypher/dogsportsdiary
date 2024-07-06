import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      var diaryBox = Hive.box(Constants.diaryBox);
      await diaryBox.compact();

      var dogBox = Hive.box(Constants.dogBox);
      await dogBox.compact();
    }
  }
}