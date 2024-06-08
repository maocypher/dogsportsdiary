import 'dart:convert' show json;
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:flutter/services.dart';

class DogSportsService {
  Future<Map<String, dynamic>?> loadJsonFileForSports(DogSports selectedSport) async {
    String fileName = selectedSport.name;
    String jsonString = await rootBundle.loadString('assets/data/$fileName.json');
    return json.decode(jsonString);
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DogSportsService>(() => DogSportsService());
  }

  static DogSportsService get settingsViewModel {
    return ServiceProvider.locator<DogSportsService>();
  }
}