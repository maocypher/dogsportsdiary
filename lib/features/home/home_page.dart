import 'package:dog_sports_diary/features/home/home_state.dart';
import 'package:flutter/material.dart';

class DogSportsHomePage extends StatefulWidget {
  const DogSportsHomePage({super.key}); //required this.title

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Hundesport Tagebuch';

  @override
  State<DogSportsHomePage> createState() => DogSportsHomePageState();
}