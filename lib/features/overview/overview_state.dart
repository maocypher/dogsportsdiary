import 'package:dog_sports_diary/features/overview/overview_tab.dart';
import 'package:dog_sports_diary/features/overview/overview_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewState extends State<OverviewTab> {
  final OverviewViewModel overviewViewModel = OverviewViewModel.overviewViewModel;
  final Toast toast = Toast.toast;

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<OverviewViewModel>(
        create: (_) => overviewViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(_context)!.overview),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(AppLocalizations.of(_context)!.createBackup),
                    onTap: () async {
                      //await onCreateBackupTapAsync();
                    },
                  ),
                  const Divider(), // Add a divider between entries
                  ListTile(
                    title: Text(AppLocalizations.of(_context)!.restoreBackup),
                    onTap: () async {
                      //await onRestoreBackupTapAsync();
                    },
                  ),
                  const Divider(), // Add a divider between entries
                  // Add more ListTile widgets as needed
                ],
              ),
            ),
          );
        });
  }

  void showSplashScreen(){
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}