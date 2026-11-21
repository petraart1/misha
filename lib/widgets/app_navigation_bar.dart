import 'package:flutter/material.dart';

import '../routes.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isDetailPage = ModalRoute.of(context)?.settings.name == Routes.detail;
    return NavigationBar(
      backgroundColor: Colors.lightGreenAccent.shade100,
      indicatorColor: Colors.lightGreenAccent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        final navigator = Navigator.of(context);
        if (index == 0) {
          if (currentIndex == 1 || isDetailPage) {
            navigator.popUntil(ModalRoute.withName(Routes.home));
          }
        } else if (currentIndex == 0) {
          if (isDetailPage) {
            navigator.pushReplacementNamed(Routes.profile);
          } else {
            navigator.pushNamed(Routes.profile);
          }
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Главная',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
