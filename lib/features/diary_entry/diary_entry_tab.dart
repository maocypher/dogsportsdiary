import 'package:dog_sports_diary/domain/entities/sports.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab_state.dart';
import 'package:dog_sports_diary/features/diary_entry/diary_entry_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DiaryEntryTab extends StatefulWidget {

  final DiaryEntryViewModel diaryEntryViewModel;
  final String label;

  const DiaryEntryTab({
    required this.diaryEntryViewModel,
    required this.label,
    super.key
  });

  @override
  State<DiaryEntryTab> createState() => DiaryEntryTabState(diaryEntryViewModel: diaryEntryViewModel, label: label);
}
