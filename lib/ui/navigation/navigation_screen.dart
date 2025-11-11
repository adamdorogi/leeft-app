import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:leeft/l10n/app_localizations.dart';

/// A screen with a bottom navigation bar for encapsulating a custom navigation
/// shell.
class NavigationScreen extends StatelessWidget {
  /// Creates a [NavigationScreen].
  const NavigationScreen({super.key, required this.navigationShell});

  /// The container of parallel navigation trees, typically created by a
  /// [StatefulShellRoute].
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: [
          // Routines tab.
          NavigationDestination(
            icon: const Icon(Icons.fitness_center),
            label: AppLocalizations.of(context)!.routines,
          ),
          // Profile tab.
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
