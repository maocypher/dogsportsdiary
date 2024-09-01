import 'package:dog_sports_diary/domain/value_objects/exercise.dart';

class HistoryCount{
  final Exercises exercise;
  int count;

  HistoryCount({required this.exercise, required this.count});

  increaseCount(int addCount){
    count += addCount;
  }
}