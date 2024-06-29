import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowDiaryEntryTab extends StatelessWidget {
  const ShowDiaryEntryTab({
    required this.label,
    super.key
  });

  /// The label
  final String label;

  /// The path to the detail page
  //final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center( //Todo: show list of last entries in descending order
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Press the + button to add a diary entry'),
            const Padding(padding: EdgeInsets.all(4)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/diary/new-entry');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}