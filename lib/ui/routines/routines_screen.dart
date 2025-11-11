import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/create_routine/create_routine_screen.dart';
import 'package:leeft/ui/create_routine/create_routine_viewmodel.dart';

/// A screen for viewing saved routines.
class RoutinesScreen extends StatelessWidget {
  /// Creates a [RoutinesScreen].
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.routines)),
      body: Center(
        child:
            // Link to Create Routine page.
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.createRoutine),
              onPressed: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) =>
                      CreateRoutineScreen(viewModel: CreateRoutineViewModel()),
                ),
              ),
            ),
      ),
    );
  }
}
