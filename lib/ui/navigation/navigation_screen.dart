import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:leeft/l10n/app_localizations.dart';

/// A screen with a bottom navigation bar encapsulating a navigation shell.
class NavigationScreen extends StatelessWidget {
  /// Creates a [NavigationScreen] with a [navigationShell].
  ///
  /// The [navigationShell] contains the parallel navigation trees for this
  /// screen's bottom navigation bar.
  const NavigationScreen({required this.navigationShell, super.key});

  /// The navigation shell.
  ///
  /// Contains the parallel navigation trees for this screen's bottom navigation
  /// bar.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: [
          // The routines tab.
          NavigationDestination(
            icon: const Icon(Icons.fitness_center),
            label: AppLocalizations.of(context).routines,
          ),
          // The profile tab.
          NavigationDestination(
            icon: const Icon(Icons.account_circle),
            label: AppLocalizations.of(context).profile,
          ),
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
      ),
    );
  }
}
