import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/overview/overview_tab.dart';
import 'package:dog_sports_diary/features/overview/overview_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewState extends State<OverviewTab> {
  final OverviewViewModel overviewViewModel = OverviewViewModel
      .overviewViewModel;
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
            body: Consumer<OverviewViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(_context)!.diaryPageNoDogs),
                  );
                }
                return overviewCarouselView();
              }
            ),
            floatingActionButton: addDogButton(context, overviewViewModel),
          );
        }
    );
  }

  Widget overviewCarouselView(){
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                enableInfiniteScroll: false
            ),
            itemCount: overviewViewModel.dogs.length,
            itemBuilder: (BuildContext context, int itemIndex,
                int pageViewIndex) =>
                Card(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: overviewViewModel
                                .dogs[itemIndex].imagePath == null
                                ? null
                                : FileImage(File(
                                overviewViewModel.dogs[itemIndex]
                                    .imagePath!)),
                            backgroundColor: overviewViewModel
                                .dogs[itemIndex].imagePath == null
                                ? Colors.grey
                                : null,
                          ),
                          title: Text(
                              overviewViewModel.dogs[itemIndex].name),
                          subtitle: Text(AppLocalizations.of(_context)!
                              .overviewLast28Days),
                        ),
                        Column(
                            children: [overviewViewModel
                                .getHistory(
                                overviewViewModel.dogs[itemIndex].id!)
                                .isEmpty
                                ? Text(AppLocalizations.of(_context)!
                                .overviewNoDataLast28Days)
                                : SizedBox(
                              width: double.infinity,
                              // Take up the full width of the parent
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text(
                                      AppLocalizations.of(_context)!
                                          .exercise)),
                                  DataColumn(label: Text(
                                      AppLocalizations.of(_context)!
                                          .count)),
                                ],
                                rows: overviewViewModel.getHistory(
                                    overviewViewModel.dogs[itemIndex]
                                        .id!).map((historyCount) {
                                  return
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              // _context.push('${Constants.routeOverview}/${overviewViewModel.dogs[itemIndex]
                                              //     .id!}/${Constants.routeOverviewHistory}/${historyCount.exercise}');
                                            },
                                            child: Text(AppLocalizations.of(context)!.exercises(historyCount!.exercise.toString())),
                                          ),),
                                        DataCell(
                                            Text(historyCount.count.toString())),
                                      ],
                                    );
                                }).toList(),
                              ),
                            ),
                            ]
                        ),
                      ],
                    ),
                  ),
                )
        )
    );
  }

  Widget? addDogButton(BuildContext context, OverviewViewModel viewModel){
    if(viewModel.dogs.isEmpty) {
      return FloatingActionButton(
        key: const ValueKey("btnAddDiaryEntry"),
        onPressed: () {
          context.push('${Constants.routeDog}/${Constants.routeDogNew}');
        },
        child: const Icon(Icons.add),
      );
    }
    else{
      return null;
    }
  }
}