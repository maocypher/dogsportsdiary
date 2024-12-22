import 'dart:io';

import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_tab.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowDiaryEntryState extends State<ShowDiaryEntryTab> {
  final ShowDiaryEntryViewmodel showDiaryEntryViewmodel = ShowDiaryEntryViewmodel.showDiaryEntryViewModel;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    showDiaryEntryViewmodel.init();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<ShowDiaryEntryViewmodel>(
        create: (_) => showDiaryEntryViewmodel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(_context)!.diary),
            ),
            body: Consumer<ShowDiaryEntryViewmodel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(_context)!.diaryPageNoDogs),
                  );
                }

                return ListView.builder(
                  itemCount: viewModel.dogs.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      initiallyExpanded: true,
                      title: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: viewModel.dogs[index].imagePath == null ? null : FileImage(File(viewModel.dogs[index].imagePath!)),
                          backgroundColor: viewModel.dogs[index].imagePath == null ? Colors.grey : null,
                        ),
                        title: Text(viewModel.dogs[index].name),
                      ),
                      children: [
                        showHomework(index)!,
                        ...listGroupedDiaryEntires(index)
                      ],
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              key: const ValueKey("btnAddDiaryEntry"),
              onPressed: () {
                var hasDogs = showDiaryEntryViewmodel.hasAnyDogs();

                if (!hasDogs) {
                  _context.push('${Constants.routeDog}/${Constants.routeDogNew}');
                } else {
                  _context.push('${Constants.routeDiary}/${Constants.routeDiaryNew}');
                }
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Widget? showHomework(int dogIndex){
    var dog = showDiaryEntryViewmodel.dogs[dogIndex];
    var homework = showDiaryEntryViewmodel.loadHomework(dog.id!);

    List<Widget> homeworkWidgets = homework.expand((diaryEntry) {
      var ratings = diaryEntry.exerciseRating!
          .where((rating) => rating.notes != null && rating.notes!.trim().isNotEmpty)
          .toList();

      return ratings.map((rating) => ListTile(
        title: Text(rating.notes!),
        subtitle: Text("${DateFormat('yyyy-MM-dd').format(diaryEntry.date)} - ${AppLocalizations.of(context)!
            .exercises(rating.exercise.toString())}"),
      )).toList();
    }).toList();

    if(homeworkWidgets.isEmpty){
      homeworkWidgets.add(ListTile(
        title: Text("Keep up the training"),
        subtitle: Text("You don't have any homework currently"),
      ));
    }

    return ExpansionTile(
      title: Text("Homework"),
      children: homeworkWidgets,
    );
  }

  List<Widget> listGroupedDiaryEntires(int dogIndex){
    var dog = showDiaryEntryViewmodel.dogs[dogIndex];

    return dog.sports.entries.where((sport) => showDiaryEntryViewmodel.diaryEntries
        .where((diaryEntry) => diaryEntry.dogId == dog.id && diaryEntry.sport!.key == sport.key)
        .isNotEmpty).map((entry) {
      return ExpansionTile(
        title: Text(AppLocalizations.of(_context)!.dogSports(entry.key.toString())),
        children: showDiaryEntryViewmodel.diaryEntries.where((e) => e.dogId == dog.id && entry.key == e.sport!.key).map((diaryEntry) {
          return GestureDetector(
              onTap: () {
                // Handle the tab event here
                _context.push('${Constants.routeDiary}/${diaryEntry.id}');
              },
              child: ListTile(
                title: Text(DateFormat('yyyy-MM-dd').format(diaryEntry.date)),
              )
          );
        }).toList(),
      );
    }).toList();
  }
}