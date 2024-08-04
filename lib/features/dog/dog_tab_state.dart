import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/domain/entities/sports_classes.dart';
import 'package:dog_sports_diary/features/dog/dog_tab.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DogTabState extends State<DogTab> {

  final DogViewModel dogViewModel = DogViewModel.dogViewModel;

  TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dogViewModel.initAsync(widget.idStr);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DogViewModel>(
        create: (_) => dogViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.dog),
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
                    dogViewModel.deleteDogAsync();
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
                        Stack(
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
                            Positioned(
                              bottom: -6, // adjust as needed
                              right: 0, // adjust as needed
                              child: ElevatedButton(
                                onPressed: viewModel.pickImageAsync,
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(4.0),
                                  minimumSize: Size.zero,
                                  fixedSize: const Size(48, 48),
                                ),
                                child: const Icon(Icons.add_a_photo),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        TextFormField(
                          key: const ValueKey("txtBoxName"),
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
                          key: const ValueKey("txtBoxDateOfBirth"),
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
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                                initialEntryMode: DatePickerEntryMode.calendarOnly);

                            if (date != null) {
                              viewModel.updateDateOfBirth(date);
                            }
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),
                        TextFormField(
                          key: const ValueKey("txtBoxWeight"),
                          controller: _weightController = TextEditingController(
                            text: viewModel.dog?.weight.toString(),
                          ),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.weight,
                            suffixText: 'kg',
                            icon: const Icon(Icons.scale),
                          ),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: true,
                          ),
                          onChanged: (value) {
                            viewModel.updateWeight(value);
                          },
                          onTap: () {
                            //reset text field to empty string without changing the dog.weight
                            if(_weightController.text == Constants.initWeight.toString()) {
                              _weightController.text = '';
                            }
                          },
                        ),
                        const SizedBox(height: Constants.uiSpacer),

                        //--------- DogSports Multiselection ----------------
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<DogSports>(
                            isExpanded: true,
                            hint: Text(
                              AppLocalizations.of(context)!.sportsMultiSelectionHint,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: viewModel.sportList.map((sport) {
                              return DropdownItem(
                                value: sport,
                                closeOnTap: false,
                                child: ValueListenableBuilder<List<DogSports>>(
                                  valueListenable: viewModel.selectedSports,
                                  builder: (context, multiValue, _) {
                                    final isSelected = multiValue.contains(sport);
                                    return Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(Icons.check_box_outline_blank),
                                          const SizedBox(),
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!.dogSports(sport.name),
                                              style: const TextStyle(
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                            multiValueListenable: viewModel.selectedSports,
                            onChanged: (value) {
                              viewModel.selectSports(value);
                            },
                            selectedItemBuilder: (context) {
                              return viewModel.sportList.map(
                                    (item) {
                                  return ValueListenableBuilder<List<DogSports>>(
                                      valueListenable: viewModel.selectedSports,
                                      builder: (context, multiValue, _) {
                                        return Text(
                                          multiValue
                                              .select((item, _) => AppLocalizations.of(context)!.dogSports(item.name))
                                              .where((item) => item != 'All')
                                              .join(', '),
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        );
                                      });
                                },
                              ).toList();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(left: 16, right: 8),
                              height: 40
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        //---------------------------------------------------

                        const SizedBox(height: Constants.uiSpacer),
                        StreamBuilder<List<DogSports>>(
                          stream: viewModel.selectedDogSportsStream,
                          builder: (context, snapshot) {
                            return Column(
                              children: viewModel.selectedSports.value.map((dogSport) {
                                return DropdownButtonFormField<DogSportsClasses>(
                                  key: ValueKey("drpDown$dogSport"),
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
                Provider.of<DogViewModel>(context, listen: false).saveDogAsync();
                context.pop();
              },
              child: const Icon(Icons.save),
            ),
          );
        });
  }
}