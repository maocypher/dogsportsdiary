import 'package:dog_sports_diary/domain/value_objects/rating.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryEntry{
  final Rating rating;
  final DateTime date;

  HistoryEntry({required this.rating, required this.date});

  FlSpot toFlSpot(DateTime firstDate){
    return FlSpot(date.difference(firstDate).inDays.toDouble(), rating.rating);
  }
}