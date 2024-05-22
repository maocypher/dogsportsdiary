import 'package:dog_sports_diary/features/settings/settings_page.dart';
import 'package:dog_sports_diary/presentation/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SettingsPageState extends State<SettingsPage> {
  int _counter = 0;
  int selectedPageIndex = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const [
        Center(
          child: Text(
            'Learn 📗',
          ),
        ),
        Center(
          child: Text(
            'Relearn 👨‍🏫',
          ),
        ),
        Center(
          child: Text(
            'Unlearn 🐛',
          ),
        ),
      ][selectedPageIndex],
      bottomNavigationBar: const CustomNavigationBar(selectedPageIndex: 3),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}