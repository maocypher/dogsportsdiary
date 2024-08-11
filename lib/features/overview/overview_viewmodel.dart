import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:flutter/material.dart';

class OverviewViewModel extends ChangeNotifier {
  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<OverviewViewModel>(() => OverviewViewModel());
  }

  static OverviewViewModel get overviewViewModel {
    return ServiceProvider.locator<OverviewViewModel>();
  }
}