import 'package:choice/choice.dart';
import 'package:dog_sports_diary/features/history/history_range.dart';
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
    historyViewModel.init(widget.dogIdStr, widget.exerciseIdStr);
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
              body: Column(
                children: [getTimeRangeSelection(), getLineChartForHistory()],
              ));
        });
  }

  Widget getLineChartForHistory() {
    return Stack(
      children: <Widget>[
        AspectRatio(
            aspectRatio: 1.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.exercises(historyViewModel.exercise.toString()),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                      left: 12,
                      top: 24,
                      bottom: 12,
                    ),
                    child: Consumer<HistoryViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.history.isEmpty) {
                          return Center(
                            child: Text(AppLocalizations.of(context)!.historyNoData),
                          );
                        }
                        return LineChart(
                          historyLineChartData(),
                        );
                      }
                    )
                  ))
                ])
        ),
      ],
    );
  }

  Widget getTimeRangeSelection(){
    return Choice<HistoryRange>.inline(
      clearable: false,
      value: ChoiceSingle.value(historyViewModel.selectedHistoryRange),
      onChanged: ChoiceSingle.onChanged(historyViewModel.setSelectedHistoryRange),
      itemCount: HistoryRange.values.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          showCheckmark: false,
          selected: state.selected(HistoryRange.values[i]),
          onSelected: state.onSelected(HistoryRange.values[i]),
          label: Text(AppLocalizations.of(context)!.historyRange(HistoryRange.values[i].name)),
        );
      },
      listBuilder: ChoiceList.createScrollable(
        spacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }

  LineChartData historyLineChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: historyViewModel.interval,
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
            interval: historyViewModel.interval,
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
          curveSmoothness: 0.1,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
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

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(formatter.format(historyViewModel.firstDate.add(Duration(days: value.toInt()))), style: style),
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