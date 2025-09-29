import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_screen.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createRoutine)),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addExercises),
          onPressed: () => Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddExercisesScreen(
                viewModel: AddExercisesViewModel(
                  exerciseRepository: context.read(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
