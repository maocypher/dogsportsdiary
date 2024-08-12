import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/overview_service.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/exercise.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OverviewViewModel extends ChangeNotifier {
  final DogRepository _repository = DogRepository.dogRepository;
  final OverviewService _overviewService = OverviewService.overviewService;

  late List<Dog> _dogs = List.empty();

  List<Dog> get dogs => _dogs;
  Map<DogSports, List<(Exercises, int)>> _history = {};

  void init() {
    loadDogs();
  }

  void loadDogs() {
    var dogsResult = _repository.getAllDogs();

    if(dogsResult.isSuccess()) {
      _dogs = dogsResult.tryGetSuccess() ?? List.empty();
      notifyListeners();
    }
  }
  
  List<BarChartGroupData> getBarChartData(int dogId,DogSports sport)
  {
    List<BarChartGroupData> barChartData = [];
    _history = _overviewService.getHistoryOfLastFourWeeks(dogId);

    if(_history[sport] == null){
      return barChartData;
    }

    var sportHistory = _history[sport];
    
    for(var i = 0; i < sportHistory!.length; i++){
      barChartData.add(BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: sportHistory[i].$2.toDouble())
          ]
      ));
    }

    return barChartData;
  }

  Widget getTitles(DogSports sport, double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = value.toInt().toString();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData getTitlesData(DogSports sport) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) => getTitles(sport, value, meta),
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: true),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<OverviewViewModel>(() => OverviewViewModel());
  }

  static OverviewViewModel get overviewViewModel {
    return ServiceProvider.locator<OverviewViewModel>();
  }
}