import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:dog_sports_diary/features/dog/dog_viewmodel.dart';
import 'package:flutter/material.dart';

import 'dog_tab_state.dart';

class DogTab extends StatefulWidget {
  final DogViewModel dogViewModel;
  final String label;

  const DogTab({
    required this.dogViewModel,
    required this.label,
    Dog? dog,
    super.key
  });

  @override
  State<DogTab> createState() => DogTabState(dogViewModel: dogViewModel, label: label);
}
