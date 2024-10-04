import 'package:dog_sports_diary/domain/value_objects/backup.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:dog_sports_diary/presentation/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsState extends State<SettingsTab> {
  final SettingsViewModel settingsViewModel = SettingsViewModel.settingsViewModel;
  final ShowDogsViewModel showDogsViewModel = ShowDogsViewModel.showDogsViewModel;
  final ShowDiaryEntryViewmodel showDiaryEntryViewModel = ShowDiaryEntryViewmodel.showDiaryEntryViewModel;
  final Toast toast = Toast.toast;

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
                      await onCreateBackupTapAsync();
                    },
                  ),
                  const Divider(), // Add a divider between entries
                  ListTile(
                    title: Text(AppLocalizations.of(_context)!.restoreBackup),
                    onTap: () async {
                      await onRestoreBackupTapAsync();
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
  
  Future<void> onCreateBackupTapAsync() async{
    showSplashScreen();

    var backupResult = await settingsViewModel.backupService.backupAsync();
    if(!mounted) {
      return;
    }

    _context.pop();

    switch (backupResult) {
      case BackupResult.success:
        toast.showToast(msg: AppLocalizations.of(_context)!.backupSuccessful);
        break;

      case BackupResult.failure:
        toast.showToast(msg: AppLocalizations.of(_context)!.backupFailed);
        break;

      case BackupResult.cancelled:
        toast.showToast(msg: AppLocalizations.of(_context)!.backupCancelled);
        break;

      default:
        break;
    }
  }

  Future<void> onRestoreBackupTapAsync() async{
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);

    if(!mounted) {
      return;
    }

    if(result == null) {
      toast.showToast(msg: AppLocalizations.of(_context)!.restoreCancelled);
      return;
    }

    var filePath = result.files.first.path;
    if(filePath == null) {
      toast.showToast(msg: AppLocalizations.of(_context)!.restoreFailed);
    }

    //AlertDialog
    await showRestoreAlertAsync(filePath!);
  }

  Future<void> showRestoreAlertAsync(String filePath) async {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(_context)!.restoreBackup),
          content: Text(AppLocalizations.of(_context)!.restoreBackupHintText),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(_context)!.buttonCancel),
              onPressed: () {
                _context.pop();
                toast.showToast(msg: AppLocalizations.of(_context)!.restoreCancelled);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(_context)!.buttonRestore),
              onPressed: () async {
                _context.pop();
                await restoreBackupAsync(filePath);
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> restoreBackupAsync(String filePath) async {
    showSplashScreen();

    var result = await settingsViewModel.backupService.restoreAsync(filePath);
    showDogsViewModel.init();
    showDiaryEntryViewModel.init();
    await Future.delayed(const Duration(seconds: 1)); // stop flickering of splash screen

    if(!mounted) {
      return;
    }

    _context.pop();

    switch(result) {
      case BackupResult.success:
        toast.showToast(msg: AppLocalizations.of(_context)!.restoreSuccessful);
        break;

      case BackupResult.failure:
        toast.showToast(msg: AppLocalizations.of(_context)!.restoreFailed);
        break;

      case BackupResult.cancelled:
        toast.showToast(msg: AppLocalizations.of(_context)!.restoreCancelled);
        break;

      default:
        break;
    }
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