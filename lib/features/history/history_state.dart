import 'package:dog_sports_diary/features/history/history_tab.dart';
import 'package:dog_sports_diary/features/history/history_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryState extends State<HistoryTab> {
  final HistoryViewModel historyViewModel = HistoryViewModel
      .historyViewModel;
  final Toast toast = Toast.toast;

  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    historyViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<HistoryViewModel>(
        create: (_) => historyViewModel,
    builder: (context, child) {
    return Scaffold(
    appBar: AppBar(
    title: Text(AppLocalizations.of(_context)!.overview),
    ),
    body: const Padding(
    padding: EdgeInsets.all(0.0),
    ));
    });
  }
}