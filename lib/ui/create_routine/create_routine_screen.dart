import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_screen.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/ui/create_routine/create_routine_viewmodel.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({super.key, required this.viewModel});

  final CreateRoutineViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createRoutine)),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (_, child) => ListView.builder(
          itemBuilder: (_, index) {
            if (index == viewModel.addedExerciseIds.length) {
              return child;
            }

            return ListTile(title: Text(viewModel.addedExerciseIds[index]));
          },
          itemCount: viewModel.addedExerciseIds.length + 1,
        ),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addExercises),
          onPressed: () async {
            final exercises = await Navigator.of(context, rootNavigator: true)
                .push<UnmodifiableSetView<String>>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddExercisesScreen(
                      viewModel: AddExercisesViewModel(
                        exerciseRepository: context.read(),
                      ),
                    ),
                  ),
                );
            viewModel.addExerciseIds(exercises);
          },
        ),
      ),
    );
  }
}
