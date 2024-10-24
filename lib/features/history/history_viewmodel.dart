import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/history_service.dart';
import 'package:dog_sports_diary/domain/value_objects/exercise.dart';
import 'package:dog_sports_diary/domain/value_objects/history_entry.dart';
import 'package:dog_sports_diary/features/history/history_range.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  final HistoryService _historyService = HistoryService.historyService;

  double get interval => dateRange / 4 == 0 ? 1 : dateRange / 4;
  double get dateRange => _history.isEmpty ? 0 : _history.last.date.difference(_history.first.date).inDays.toDouble();
  DateTime get firstDate => _history.isEmpty ? DateTime.now() : _history.first.date;
  List<FlSpot> get history => _history.map((x) => x.toFlSpot(_history.first.date)).toList();
  List<HistoryEntry> _history = [];
  HistoryRange selectedHistoryRange = HistoryRange.fourWeeks;

  void setSelectedHistoryRange(HistoryRange? value) {
    selectedHistoryRange = value ?? HistoryRange.fourWeeks;

    switch(selectedHistoryRange) {
      case HistoryRange.fourWeeks:
        loadHistory(DateTime.now().subtract(const Duration(days: 28)), DateTime.now());
        break;
      case HistoryRange.threeMonths:
        loadHistory(DateTime.now().subtract(const Duration(days: 90)), DateTime.now());
        break;
      case HistoryRange.sixMonths:
        loadHistory(DateTime.now().subtract(const Duration(days: 180)), DateTime.now());
        break;
      case HistoryRange.oneYear:
        loadHistory(DateTime.now().subtract(const Duration(days: 365)), DateTime.now());
        break;
    }

    notifyListeners(); //TODO: history chart is not reloaded
  }

  List<Widget> legend = [];

  int? _dogId;
  Exercises? _exercise;
  Exercises? get exercise => _exercise;

  void init(String? dogIdStr, String? exerciseIdStr) {
    if(dogIdStr != null && exerciseIdStr != null) {
      _dogId = int.tryParse(dogIdStr);
      _exercise = Exercises.values.firstWhere((x) => x.toString() == exerciseIdStr);
      setSelectedHistoryRange(HistoryRange.fourWeeks);
    }
  }

  void loadHistory(DateTime startDate, DateTime endDate) {
    _history = _historyService.getHistoryOfExerciseDate(_dogId!, _exercise!, startDate, endDate);
  }

  static inject() {
    ServiceProvider.locator.registerFactory<HistoryViewModel>(() => HistoryViewModel());
  }

  static HistoryViewModel get historyViewModel {
    return ServiceProvider.locator<HistoryViewModel>();
  }
}