import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DogTabState extends State<DogTab> {

  final DogViewModel dogViewModel;
  final String label;

  DogTabState({
        required this.dogViewModel,
        required this.label,
        Dog? dog
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DogViewModel>(
        create: (_) => dogViewModel,
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
                    dogViewModel.deleteDog();
                    context.pop();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Consumer<DogViewModel>(
                builder: (context, viewModel, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey,
                          child: viewModel.imageFile != null
                              ? AspectRatio(
                            aspectRatio: 1,
                            child: ClipOval(
                              child: Image.file(
                                viewModel.imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : const Icon(Icons.person),
                        ),
                        ElevatedButton(
                          onPressed: viewModel.pickImage,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: const Icon(Icons.add_a_photo),
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dog?.name,
                          ),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.name,
                            icon: const Icon(Icons.pets),
                          ),
                          onChanged: (value) {
                            viewModel.updateName(value);
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dateOfBirth,
                          ),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.dateOfBirth,
                            icon: const Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (date != null) {
                              viewModel.updateDateOfBirth(date);
                            }
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dog?.weight.toString() ?? '',
                          ),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.weight,
                            suffixText: 'kg',
                            icon: const Icon(Icons.scale),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.updateWeight(value);
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        CustomDropdown<DogSports>.multiSelect(
                          initialItems: viewModel.selectedSports,
                          items: viewModel.sportList,
                          onListChanged: (value) {
                            viewModel.selectSports(value);
                          },
                          hintText: AppLocalizations.of(context)!.sportsMultiSelectionHint,
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        StreamBuilder<List<DogSports>>(
                          stream: viewModel.selectedDogSportsStream,
                          builder: (context, snapshot) {
                            return Column(
                              children: viewModel.selectedSports.map((dogSport) {
                                return DropdownButtonFormField<DogSportsClasses>(
                                  value: viewModel.sportClasses[dogSport]?.first,
                                  items: viewModel.sportClasses[dogSport]?.map((sportsClass) {
                                    return DropdownMenuItem<DogSportsClasses>(
                                      value: sportsClass,
                                      child: Text(AppLocalizations.of(context)!.dogSportsClasses(sportsClass.toString())),
                                    );
                                  }).toList(),
                                  onChanged: (sportsClass) {
                                    viewModel.addSports(dogSport, sportsClass!);
                                  },
                                );
                              }).toList(),
                            );
                          },
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
                Provider.of<DogViewModel>(context, listen: false).saveDog();
                context.pop();
              },
              child: const Icon(Icons.save),
            ),
          );
        });
  }
}