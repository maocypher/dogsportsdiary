import 'dart:io';

import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShowDogsTab extends StatelessWidget {
  final ShowDogsViewModel showDogViewModel;

  /// The label
  final String label;

  ShowDogsTab({
    required this.showDogViewModel,
    required this.label,
    super.key
  })
  {
    showDogViewModel.loadDogs();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowDogsViewModel>(
        create: (_) => showDogViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(label),
            ),
            body: Consumer<ShowDogsViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.dogs.isEmpty) {
                  return const Center(
                    child: Text('Press the + button to add a dog'),
                  );
                }

                return ListView.builder(
                  itemCount: viewModel.dogs.length,
                  itemBuilder: (context, index) {
                    final dog = viewModel.dogs[index];
                    return SizedBox(
                      height: 80,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: dog.imagePath == null ? null : FileImage(File(dog.imagePath!)),
                          backgroundColor: dog.imagePath == null ? Colors.grey : null,
                        ),
                        title: Text(dog.name),
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