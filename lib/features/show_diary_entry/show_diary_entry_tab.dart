import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShowDiaryEntryTab extends StatelessWidget {
  final ShowDiaryEntryViewmodel showDiaryEntryViewmodel;

  const ShowDiaryEntryTab({
    required this.showDiaryEntryViewmodel,
    super.key
  });

  /// The path to the detail page
  //final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowDiaryEntryViewmodel>(
        create: (_) => showDiaryEntryViewmodel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(Constants.pageTitleDiary),
            ),
            body: Consumer<ShowDiaryEntryViewmodel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return const Center(
                    child: Text('You have no dogs added yet'),
                  );
                }

                return ListView.builder(
                  itemCount: viewModel.diaryEntries.length,
                  itemBuilder: (context, index) {
                    final diaryEntry = viewModel.diaryEntries[index];
                    return SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the tab event here
                          context.push('/diary/${diaryEntry.id}');
                        },
                        child: ListTile(
                          title: Text("${diaryEntry.date} - ${diaryEntry.sport} - ${viewModel.dogs.first.name}"),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.push('/diary/new-entry');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}