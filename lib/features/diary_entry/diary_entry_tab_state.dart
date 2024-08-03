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
import 'package:flutter_slidable/flutter_slidable.dart';
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
                                  text: viewModel.diaryEntry?.temperature.toString() ?? '${Constants.initTemperature}',
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
                                    text: viewModel.diaryEntry?.trainingDurationInMin.toString() ?? '${Constants.initMinutes}',
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
                                    text: viewModel.diaryEntry?.warmUpDurationInMin.toString() ?? '${Constants.initMinutes}',
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
                                    text: viewModel.diaryEntry?.coolDownDurationInMin.toString() ?? '${Constants.initMinutes}',
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
                                    text: viewModel.diaryEntry?.trainingGoal,
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
                                    text: viewModel.diaryEntry?.highlight,
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
                                    text: viewModel.diaryEntry?.distractions,
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
                                    text: viewModel.diaryEntry?.notes,
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
                                children: viewModel.selectedExercises.map((exerciseRating) {
                                  return Slidable(
                                    key: ValueKey(exerciseRating),
                                    // The start action pane is the one at the left or the top side.
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const DrawerMotion(),
                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) => viewModel.updateIsPlanned(exerciseRating.exercise),
                                          backgroundColor: Colors.blueAccent,
                                          foregroundColor: Colors.white,
                                          icon: Icons.star,
                                          label: AppLocalizations.of(context)!.ratingPlan,
                                        ),
                                      ],
                                    ),

                                    // The child of the Slidable is what the user sees when the
                                    // component is not dragged.
                                    child: ListTile(
                                      leading: exerciseRating.isPlanned
                                          ? const Icon(Icons.star)
                                          : null,
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(AppLocalizations.of(context)!.exercises(exerciseRating.exercise.toString())),
                                          ),
                                          StarRating(
                                            rating: exerciseRating.rating,
                                            allowHalfRating: false,
                                            onRatingChanged: (newRating) => setState(() => viewModel.updateRating(exerciseRating.exercise, newRating)),
                                          ),
                                        ],
                                      ),
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