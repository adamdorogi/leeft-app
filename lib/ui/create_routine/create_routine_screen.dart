import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_screen.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createRoutine)),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addExercises),
          onPressed: () => Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => AddExercisesScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
