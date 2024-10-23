import 'package:dog_sports_diary/features/history/history_tab.dart';
import 'package:dog_sports_diary/features/history/history_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryState extends State<HistoryTab> {
  final HistoryViewModel historyViewModel = HistoryViewModel
      .historyViewModel;
  final Toast toast = Toast.toast;

  List<Color> gradientColors = [
    Colors.grey,
    Colors.lightBlueAccent,
  ];

  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    historyViewModel.initAsync(widget.dogIdStr, widget.exerciseIdStr);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<HistoryViewModel>(
        create: (_) => historyViewModel,
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(_context)!.history),
              ),
              body: Padding(
                padding: EdgeInsets.all(0.0),
                child: getLineChartForHistory(),
              ));
        });
  }

  Widget getLineChartForHistory(){
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: historyViewModel.dateRange / 4,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.amber,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.green,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: historyViewModel.dateRange / 4,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: historyViewModel.dateRange,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: historyViewModel.history,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateFormat formatter = DateFormat('dd.MM');
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    // if(value.toInt() % 5 == 0) {
    //   text = Text(formatter.format(historyViewModel.firstDate.add(Duration(days: value.toInt()))), style: style);
    // }
    // else{
    //   text = const Text('', style: style);
    // }

    text = Text(formatter.format(historyViewModel.firstDate.add(Duration(days: value.toInt()))), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 3:
        text = '3';
        break;
      case 5:
        text = '5';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}