import 'package:dog_sports_diary/features/home/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const DogSportsHomePage(),
    ),
    /*GoRoute(
      path: '/learn',
      name: 'learn',
      builder: (context, state) => const LearnPage(),
    ),
    GoRoute(
      path: '/relearn',
      name: 'relearn',
      builder: (context, state) => const RelearnPage(),
    ),
    GoRoute(
      path: '/dog_name',
      name: 'dog_name',
      builder: (context, state) => const DogNamePage(),
    ),*/
  ],
);