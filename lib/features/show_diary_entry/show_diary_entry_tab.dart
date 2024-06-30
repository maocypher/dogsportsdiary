import 'dart:io';

import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowDiaryEntryTab extends StatelessWidget {
  final ShowDiaryEntryViewmodel showDiaryEntryViewmodel;

  final String label;

  const ShowDiaryEntryTab({
    required this.showDiaryEntryViewmodel,
    required this.label,
    super.key
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
                    return Column(
                      children: viewModel.dogs.map((dog) {
                        return ExpansionTile(
                          title: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: dog.imagePath == null ? null : FileImage(File(dog.imagePath!)),
                              backgroundColor: dog.imagePath == null ? Colors.grey : null,
                            ),
                            title: Text(dog.name),
                          ),
                          children: dog.sports.entries.where((sport) => viewModel.diaryEntries
                              .where((diaryEntry) => diaryEntry.dogId == dog.id && diaryEntry.sport!.key == sport.key)
                              .isNotEmpty).map((entry) {
                            return ExpansionTile(
                              title: Text(AppLocalizations.of(context)!.dogSports(entry.key.toString())),
                              children: viewModel.diaryEntries.where((e) => e.dogId == dog.id && entry.key == e.sport!.key).map((diaryEntry) {
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
                      }).toList(),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.push('${Constants.routeDiary}/${Constants.routeDiaryNewEntry}');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}