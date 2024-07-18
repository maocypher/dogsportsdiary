import 'package:dog_sports_diary/domain/entities/backup.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsState extends State<SettingsTab> {
  final SettingsViewModel settingsViewModel = SettingsViewModel.settingsViewModel;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return ChangeNotifierProvider<SettingsViewModel>(
        create: (_) => settingsViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(_context)!.settings),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(AppLocalizations.of(_context)!.createBackup),
                    onTap: () async {
                      var backupResult = await settingsViewModel.backupService.backup();
                      if(!mounted) {
                        return;
                      }

                      switch (backupResult) {
                        case BackupResult.success:
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(_context)!.backupSuccessful,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              fontSize: 16.0);
                          break;
                        case BackupResult.failure:
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(_context)!.backupFailed,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              fontSize: 16.0);

                          break;
                        case BackupResult.cancelled:
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(_context)!.backupCancelled,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              fontSize: 16.0);

                          break;
                        default:
                          break;
                      }
                    },
                  ),
                  const Divider(), // Add a divider between entries
                  ListTile(
                    title: Text(AppLocalizations.of(_context)!.importBackup),
                    onTap: () {
                      settingsViewModel.backupService.restore();
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