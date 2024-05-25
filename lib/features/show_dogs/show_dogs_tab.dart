import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShowDogsTab extends StatelessWidget {
  final ShowDogsViewModel showDogViewModel;

  /// The label
  final String label;

  /// The path to the detail page
  //final String detailsPath;

  const ShowDogsTab({
    required this.showDogViewModel,
    required this.label,
    super.key
  });

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
                    return ListTile(
                      title: Text(dog.name),
                      subtitle: Text(dog.dateOfBirth.toString()),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.go('/dog/new-dog');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}