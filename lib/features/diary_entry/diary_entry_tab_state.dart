import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DiaryEntryTabState extends State<DiaryEntryTab> {

  final DiaryEntryViewModel diaryEntryViewModel;
  final String label;

  DiaryEntryTabState({
    required this.diaryEntryViewModel,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryEntryViewModel>(
        create: (_) => diaryEntryViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(label),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    diaryEntryViewModel.deleteEntry();
                    context.pop();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Consumer<DiaryEntryViewModel>(
                builder: (context, viewModel, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: viewModel.dogList?.first.name,
                          onChanged: (dogName) {
                            viewModel.loadDog(dogName!);
                          },
                          items: viewModel.dogList?.map((dog) {
                            return DropdownMenuItem<String>(
                              value: dog.name,
                              child: Text(dog.name),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        DropdownButtonFormField<Tuple<DogSports, DogSportsClasses>>(
                          value: viewModel.selectedSport,
                          onChanged: (sport) {
                            viewModel.loadSport(sport!);
                          },
                          items: viewModel.selectedDogSports.map((sport) {
                            return DropdownMenuItem<Tuple<DogSports, DogSportsClasses>>(
                              value: sport,
                              child: Text(sport.toString()),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.date,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            icon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (date != null) {
                              viewModel.updateDate(date);
                            }
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        Column(
                          children: viewModel.selectedExercises.map((exerciseTuple) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(exerciseTuple.key.name),
                                  ),
                                  StarRating(
                                    rating: exerciseTuple.value,
                                    allowHalfRating: false,
                                    onRatingChanged: (newRating) => setState(() => viewModel.updateRating(exerciseTuple.key, newRating)),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<DiaryEntryViewModel>(context, listen: false).saveEntry();
                context.pop();
              },
              child: const Icon(Icons.save),
            ),
          );
        });
  }
}