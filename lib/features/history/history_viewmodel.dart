import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/history_service.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';
import 'package:dog_sports_diary/domain/value_objects/history_entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  final HistoryService _historyService = HistoryService.historyService;

  double get dateRange => _history.isEmpty ? 0 : _history.last.date.difference(_history.first.date).inDays.toDouble();
  DateTime get firstDate => _history.isEmpty ? DateTime.now() : _history.first.date;
  List<FlSpot> get history => _history.map((x) => x.toFlSpot(_history.first.date)).toList();
  List<HistoryEntry> _history = [];

  List<Widget> legend = [];

  int? _dogId;
  Exercises? _exercise;

  Future<void> initAsync(String? dogIdStr, String? exerciseIdStr) async {
    if(dogIdStr != null && exerciseIdStr != null) {
      _dogId = int.tryParse(dogIdStr);
      _exercise = Exercises.values.firstWhere((x) => x.toString() == exerciseIdStr);
      _history = _historyService.getHistoryOfExercise(_dogId!, _exercise!);
    }
  }

  static inject() {
    ServiceProvider.locator.registerFactory<HistoryViewModel>(() => HistoryViewModel());
  }

  static HistoryViewModel get historyViewModel {
    return ServiceProvider.locator<HistoryViewModel>();
  }
}