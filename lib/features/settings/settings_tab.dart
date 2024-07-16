import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  final SettingsViewModel settingsViewModel;

  SettingsTab():
    settingsViewModel = SettingsViewModel.settingsViewModel,
    super(key: const ValueKey('SettingsTab'));

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
        create: (_) => settingsViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.settings),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.createBackup),
                    onTap: () {
                      settingsViewModel.backupService.backup();
                    },
                  ),
                  const Divider(), // Add a divider between entries
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.importBackup),
                    onTap: () {
                      // Handle click for Entry 2
                      //print('Clicked on Entry 2');
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
}
