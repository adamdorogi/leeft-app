import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:leeft/l10n/app_localizations.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.fitness_center),
            label: AppLocalizations.of(context)!.routines,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
      ),
    );
  }
}
