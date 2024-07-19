import 'package:dog_sports_diary/domain/entities/backup.dart';
import 'package:dog_sports_diary/features/settings/settings_tab.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:dog_sports_diary/features/show_diary_entry/show_diary_entry_viewmodel.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsState extends State<SettingsTab> {
  final SettingsViewModel settingsViewModel = SettingsViewModel.settingsViewModel;
  final ShowDogsViewModel showDogsViewModel = ShowDogsViewModel.showDogsViewModel;
  final ShowDiaryEntryViewmodel showDiaryEntryViewModel = ShowDiaryEntryViewmodel.showDiaryEntryViewModel;

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
  }

  Future<void> onRestoreBackupTapAsync() async{
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);

    if(!mounted) {
      return;
    }

    if(result == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(_context)!.restoreCancelled,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          fontSize: 16.0);

      return;
    }

    var filePath = result.files.first.path;
    if(filePath == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(_context)!.restoreFailed,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          fontSize: 16.0);
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
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(_context)!.restoreCancelled,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    fontSize: 16.0);
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
    await showDogsViewModel.initAsync();
    await showDiaryEntryViewModel.initAsync();
    await Future.delayed(const Duration(seconds: 1)); // stop flickering of splash screen

    if(!mounted) {
      return;
    }

    _context.pop();

    switch(result) {
      case BackupResult.success:
        Fluttertoast.showToast(
            msg: AppLocalizations.of(_context)!.restoreSuccessful,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            fontSize: 16.0);
        break;
      case BackupResult.failure:
        Fluttertoast.showToast(
            msg: AppLocalizations.of(_context)!.restoreFailed,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            fontSize: 16.0);
        break;
      case BackupResult.cancelled:
        Fluttertoast.showToast(
            msg: AppLocalizations.of(_context)!.restoreCancelled,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            fontSize: 16.0);
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