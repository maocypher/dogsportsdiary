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
  final ShowDiaryEntryViewmodel showDiaryEntryViewmodel;

  final String label;

  ShowDiaryEntryState({
    required this.showDiaryEntryViewmodel,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowDiaryEntryViewmodel>(
        create: (_) => showDiaryEntryViewmodel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(label),
            ),
            body: Consumer<ShowDiaryEntryViewmodel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.diaryPageNoDogs),
                  );
                }

                return ListView.builder(
                  itemCount: viewModel.dogs.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: viewModel.dogs[index].imagePath == null ? null : FileImage(File(viewModel.dogs[index].imagePath!)),
                          backgroundColor: viewModel.dogs[index].imagePath == null ? Colors.grey : null,
                        ),
                        title: Text(viewModel.dogs[index].name),
                      ),
                      children: viewModel.dogs[index].sports.entries.where((sport) => viewModel.diaryEntries
                          .where((diaryEntry) => diaryEntry.dogId == viewModel.dogs[index].id && diaryEntry.sport!.key == sport.key)
                          .isNotEmpty).map((entry) {
                        return ExpansionTile(
                          title: Text(AppLocalizations.of(context)!.dogSports(entry.key.toString())),
                          children: viewModel.diaryEntries.where((e) => e.dogId == viewModel.dogs[index].id && entry.key == e.sport!.key).map((diaryEntry) {
                            return GestureDetector(
                                onTap: () {
                                  // Handle the tab event here
                                  context.push('${Constants.routeDiary}/${diaryEntry.id}');
                                },
                                child: ListTile(
                                  title: Text(DateFormat('yyyy-MM-dd').format(diaryEntry.date)),
                                )
                            );
                          }).toList(),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.push('${Constants.routeDiary}/${Constants.routeDiaryNew}');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}