import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DogTab extends StatelessWidget {
  final DogViewModel dogViewModel;

  /// The label
  final String label;

  /// The path to the detail page
  //final String detailsPath;

  const DogTab({
    required this.dogViewModel,
    required this.label,
    Dog? dog,
    super.key
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
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dog?.name,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.pets),
                          ),
                          onChanged: (value) {
                            viewModel.updateName(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dateOfBirth,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Date of Birth',
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
                              viewModel.updateDateOfBirth(date);
                            }
                          },
                        ),
                        TextFormField(
                          controller: TextEditingController(
                            text: viewModel.dog?.weight.toString() ?? '',
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Weight',
                            suffixText: 'kg',
                            icon: Icon(Icons.scale),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.updateWeight(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdown<DogSports>.multiSelect(
                          initialItems: viewModel.selectedSports,
                          items: viewModel.sportList,
                          onListChanged: (value) {
                            viewModel.selectedSports = value;
                          },
                          hintText: 'Select sports',
                        ),
                        const SizedBox(height: 16),
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
