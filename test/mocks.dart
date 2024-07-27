import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/features/show_dogs/show_dogs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

//Navigation
class MockGoRouter extends Mock implements GoRouter{}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
    goRouter: goRouter,
    child: child,
  );
}

//ViewModels
class MockShowDogsViewModel extends Mock implements ShowDogsViewModel{}

//Database
class MockHiveService extends Mock implements HiveService {}
class MockBox<T> extends Mock implements Box<T>{}