import 'package:dog_sports_diary/features/history/history_state.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {

  final String? dogIdStr;
  final String? exerciseIdStr;

  const HistoryTab({this.dogIdStr, this.exerciseIdStr, super.key});

  @override
  State<StatefulWidget> createState() => HistoryState();
}
