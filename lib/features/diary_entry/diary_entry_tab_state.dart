import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/core/utils/tuple.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryEntryTabState extends State<DiaryEntryTab> {

  final DiaryEntryViewModel diaryEntryViewModel = DiaryEntryViewModel.diaryEntryViewModel;

  TextEditingController _temperatureController = TextEditingController();
  TextEditingController _trainingDurationController = TextEditingController();
  TextEditingController _warmUpDurationController = TextEditingController();
  TextEditingController _coolDownDurationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    diaryEntryViewModel.initAsync(widget.idStr);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryEntryViewModel>(
        create: (_) => diaryEntryViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.diaryEntry),
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
                    diaryEntryViewModel.deleteEntryAsync();
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
                          value: viewModel.selectedDog,
                          onChanged: (dog) {
                            if(dog != null){
                              viewModel.loadDogAsync(dog.id!, null);
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
                                lastDate: DateTime(2100),
                                initialEntryMode: DatePickerEntryMode.calendarOnly);

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
                                controller: _temperatureController = TextEditingController(
                                  text: viewModel.entry?.temperature.toString() ?? '${Constants.initTemperature}',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.temperature,
                                  suffixText: '°C',
                                ),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.-]'))],
                                keyboardType: const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                onChanged: (value) {
                                  viewModel.updateTemperature(value);
                                },
                                onTap: () {
                                  if(_temperatureController.text == Constants.initTemperature.toString()){
                                    _temperatureController.text = '';
                                  }
                                },
                              ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: _trainingDurationController = TextEditingController(
                                    text: viewModel.entry?.trainingDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.trainingDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                  keyboardType: const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateTrainingDurationInMin(value);
                                  },
                                  onTap: () {
                                    if(_trainingDurationController.text == Constants.initMinutes.toString()){
                                      _trainingDurationController.text = '';
                                    }
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: _warmUpDurationController = TextEditingController(
                                    text: viewModel.entry?.warmUpDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.warumUpDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                  keyboardType: const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateWarmUpDurationInMin(value);
                                  },
                                  onTap: () {
                                    if(_warmUpDurationController.text == Constants.initMinutes.toString()){
                                      _warmUpDurationController.text = '';
                                    }
                                  },
                                ),
                            ),
                            ListTile(
                                title: TextFormField(
                                  controller: _coolDownDurationController = TextEditingController(
                                    text: viewModel.entry?.coolDownDurationInMin.toString() ?? '${Constants.initMinutes}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.coolDownDuration,
                                    suffixText: AppLocalizations.of(context)!.minutes,
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                  keyboardType: const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  onChanged: (value) {
                                    viewModel.updateCoolDownDurationInMin(value);
                                  },
                                  onTap: () {
                                    if(_coolDownDurationController.text == Constants.initMinutes.toString()){
                                      _coolDownDurationController.text = '';
                                    }
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
                          initiallyExpanded: true,
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
                                          child: Text(AppLocalizations.of(context)!.exercises(exerciseTuple.exercise.toString())),
                                        ),
                                        StarRating(
                                          rating: exerciseTuple.rating,
                                          allowHalfRating: false,
                                          onRatingChanged: (newRating) => setState(() => viewModel.updateRating(exerciseTuple.exercise, newRating)),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            )
                          ],
                        ),
                        const SizedBox(height: Constants.uiEndSpacer),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<DiaryEntryViewModel>(context, listen: false).saveEntryAsync();
                context.pop();
              },
              child: const Icon(Icons.save),
            ),
          );
        });
  }
}