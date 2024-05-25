import 'package:dog_sports_diary/domain/entities/ranking.dart';
import 'package:dog_sports_diary/features/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dog_sports_diary/domain/entities/theme.dart' as ds;

class SettingsTab extends StatelessWidget {
  final SettingsViewModel settingsViewModel;

  /// The label
  final String label;

  /// The path to the detail page
  //final String detailsPath;

  const SettingsTab(
      {required this.settingsViewModel, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
        create: (_) => settingsViewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(label),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<SettingsViewModel>(
                    builder: (context, settingsViewModel, child) {
                      return DropdownButtonFormField<Ranking>(
                        value: settingsViewModel.settings.ranking,
                        onChanged: (ranking) {
                          settingsViewModel.updateRanking(ranking!);
                        },
                        items: Ranking.values.map((ranking) {
                          return DropdownMenuItem<Ranking>(
                            value: ranking,
                            child: Text(ranking.name),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Consumer<SettingsViewModel>(
                    builder: (context, settingsViewModel, child) {
                      return DropdownButtonFormField<ds.Theme>(
                        value: settingsViewModel.settings.theme,
                        onChanged: (theme) {
                          settingsViewModel.updateTheme(theme!);
                        },
                        items: ds.Theme.values.map((theme) {
                          return DropdownMenuItem<ds.Theme>(
                            value: theme,
                            child: Text(theme.name),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<SettingsViewModel>(context, listen: false).saveSettings();
                //settingsViewModel.saveSettings();
              },
              child: const Icon(Icons.save),
            ),
          );
        });
  }
}
