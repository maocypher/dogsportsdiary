import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_state.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';

class ShowDiaryEntryTab extends StatefulWidget {
  final ShowDiaryEntryViewmodel showDiaryEntryViewmodel;

  final String label;

  const ShowDiaryEntryTab({
    required this.showDiaryEntryViewmodel,
    required this.label,
    super.key
  });

  @override
  State<ShowDiaryEntryTab> createState() => ShowDiaryEntryState(label: label, showDiaryEntryViewmodel: showDiaryEntryViewmodel);
}