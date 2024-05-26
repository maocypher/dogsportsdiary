import 'package:dog_sports_diary/features/show_dogs/show_dogs_state.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';

class ShowDogsTab extends StatefulWidget {
  final ShowDogsViewModel showDogViewModel;

  /// The label
  final String label;

  const ShowDogsTab({
    required this.showDogViewModel,
    required this.label,
    super.key
  });

  @override
  ShowDogsState createState() => ShowDogsState(showDogViewModel: showDogViewModel, label: label);
}