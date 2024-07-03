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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                              viewModel.loadDog(dog.id!, null);
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
                              child: Text(AppLocalizations.of(context)!.dogSportsClasses(sport.value.toString())),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.date,
                          ),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.date,
                            // icon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100));

                            if (date != null) {
                              viewModel.updateDate(date);
                            }
                          },
                        ),

                        //----- General information -----
                        ExpansionTile(
                          title: Text(
                            AppLocalizations.of(context)!.general,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: TextFormField(
                                controller: TextEditingController(
                                  text: viewModel.entry?.temperature.toString() ?? '${Constants.initTemperature}',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.temperature,
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
                                    text: viewModel.entry?.trainingDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.trainingDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
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
                                    text: viewModel.entry?.warmUpDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.warumUpDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
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
                                    text: viewModel.entry?.coolDownDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.coolDownDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    viewModel.updateCoolDownDurationInMin(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  controller: TextEditingController(
                                    text: viewModel.entry?.trainingGoal,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.trainingGoal,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateTrainingGoal(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  controller: TextEditingController(
                                    text: viewModel.entry?.highlight,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.highlight,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateHighlight(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  controller: TextEditingController(
                                    text: viewModel.entry?.distractions,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.distractions,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateDistractions(value);
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  controller: TextEditingController(
                                    text: viewModel.entry?.notes,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.notes,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateNotes(value);
                                  },
                                ),
                            ),
                          ],
                        ),

                        //----- Rating -----
                        ExpansionTile(
                          title: Text(
                            AppLocalizations.of(context)!.rating,
                            style: const TextStyle(
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
                                          child: Text(AppLocalizations.of(context)!.exercises(exerciseTuple.key.toString())),
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