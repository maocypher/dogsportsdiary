import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
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
                        //----- DiaryEntry.dogName -----
                        DropdownButtonFormField<Dog>(
                          value: viewModel.dogList?.first,
                          onChanged: (dog) {
                            if(dog != null){
                              viewModel.loadDog(dog.id!);
                            }
                          },
                          items: viewModel.dogList?.map((dog) {
                            return DropdownMenuItem<Dog>(
                              value: dog,
                              child: Text(dog.name),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        //----- DiaryEntry.sport -----
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

                        //----- General information -----
                        ExpansionTile(
                          title: Text(
                            "General information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: TextFormField(
                                controller: TextEditingController(
                                  text: viewModel.date,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  // icon: Icon(Icons.calendar_today),
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
                            ),
                            ListTile(
                              title: TextFormField(
                                controller: TextEditingController(
                                  text: viewModel.entry?.temperature.toString() ?? '',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Temperature',
                                  suffixText: '°C',
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  viewModel.updateTemperature(value);
                                },
                              ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.trainingDurationInMin.toString() ?? '',
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Training Duration',
                                    suffixText: 'min',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    viewModel.updateTrainingDurationInMin(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.warmUpDurationInMin.toString() ?? '',
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Warm-Up Duration',
                                    suffixText: 'min',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    viewModel.updateWarmUpDurationInMin(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.coolDownDurationInMin.toString() ?? '',
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Cool-Down Duration',
                                    suffixText: 'min',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    viewModel.updateCoolDownDurationInMin(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.trainingGoal,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Training goal',
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateTrainingGoal(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.highlight,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Highlight',
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateHighlight(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.distractions,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Distractions',
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateDistractions(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: TextEditingController(
                                    text: viewModel.entry?.notes,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Notes',
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateNotes(value);
                                  },
                                ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Text(
                            "Rating",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Column(
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
                            )
                          ],
                        ),
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