import 'package:dog_sports_diary/features/diary_entry/diary_entry_tab_state.dart';
import 'package:flutter/material.dart';

class DiaryEntryTab extends StatefulWidget {

  final String? idStr;

  const DiaryEntryTab({
    this.idStr,
    super.key
  });

  @override
  State<DiaryEntryTab> createState() => DiaryEntryTabState();
}
