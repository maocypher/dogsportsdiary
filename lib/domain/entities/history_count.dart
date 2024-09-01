import 'package:dog_sports_diary/domain/entities/exercise.dart';

class HistoryCount{
  final Exercises exercise;
  int count;

  HistoryCount({required this.exercise, required this.count});

  increaseCount(int addCount){
    count += addCount;
  }
}