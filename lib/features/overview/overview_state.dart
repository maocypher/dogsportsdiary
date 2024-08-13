import 'package:carousel_slider/carousel_slider.dart';
import 'package:dog_sports_diary/features/overview/overview_tab.dart';
import 'package:dog_sports_diary/features/overview/overview_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewState extends State<OverviewTab> {
  final OverviewViewModel overviewViewModel = OverviewViewModel.overviewViewModel;
  final Toast toast = Toast.toast;

  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    overviewViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<OverviewViewModel>(
        create: (_) => overviewViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(_context)!.overview),
            ),
            body: Padding(
              padding: const EdgeInsets.all(0.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,

                ),
                itemCount: overviewViewModel.dogs.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.album),
                            title: Text('Title'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('Exercise')),
                                  DataColumn(label: Text('Count')),
                                ],
                                rows: overviewViewModel.getHistory(overviewViewModel.dogs[itemIndex].id!, overviewViewModel.dogs[itemIndex].sports.keys.first).map((history) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(AppLocalizations.of(context)!.exercises(history.$1.toString()))),
                                      DataCell(Text(history.$2.toString())),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
              )
            ),
          );
        });
  }
}