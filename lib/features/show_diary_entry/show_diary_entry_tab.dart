import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
          ],
        ),
      ),
    );
  }
}