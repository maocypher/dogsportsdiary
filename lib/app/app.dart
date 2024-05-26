import 'package:dog_sports_diary/app/app_router.dart';
import 'package:flutter/material.dart';

class DogSportsApp extends StatelessWidget {
  const DogSportsApp({super.key});
  static const title = 'Hundesport Tagebuch';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}