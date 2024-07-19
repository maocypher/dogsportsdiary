import 'dart:io';

import 'package:dog_sports_diary/features/show_dogs/show_dogs_tab.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowDogsState extends State<ShowDogsTab> {
  final ShowDogsViewModel showDogViewModel = ShowDogsViewModel.showDogsViewModel;

  @override
  void initState() {
    super.initState();
    showDogViewModel.initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowDogsViewModel>(
        create: (_) => showDogViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.dogs),
            ),
            body: Consumer<ShowDogsViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.dogPageAddDogs),
                  );
                }

                return ListView.builder(
                  itemCount: viewModel.dogs.length,
                  itemBuilder: (context, index) {
                    final dog = viewModel.dogs[index];
                    return SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the tab event here
                          context.push('/dog/${dog.id}');
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: dog.imagePath == null ? null : FileImage(File(dog.imagePath!)),
                            backgroundColor: dog.imagePath == null ? Colors.grey : null,
                          ),
                          title: Text(dog.name),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.push('/dog/new-dog');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}