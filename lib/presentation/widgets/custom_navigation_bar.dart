import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//TODO: https://medium.com/@antonio.tioypedro1234/flutter-go-router-the-essential-guide-349ef39ec5b3

class CustomNavigationBar extends StatelessWidget {
  final int selectedPageIndex;

  const CustomNavigationBar({
    super.key,
    required this.selectedPageIndex
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedPageIndex,
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
          // Navigate to the home page
            context.go('/');
            break;
          case 1:
          // Navigate to show dogs page
            context.go('/dogs');
            break;
          case 2:
          // Navigate to the show diary page
            context.go('/diary');
            break;
          case 3:
          // Navigate to the settings page
            context.go('/settings');
            break;
        }
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.pets),
          icon: Icon(Icons.pets_outlined),
          label: 'Dog',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.menu_book),
          icon: Icon(Icons.menu_book_outlined),
          label: 'Diary',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}