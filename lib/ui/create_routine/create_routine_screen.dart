import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_screen.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/ui/create_routine/create_routine_viewmodel.dart';

import 'package:provider/provider.dart';

/// A screen for creating routines.
class CreateRoutineScreen extends StatelessWidget {
  /// Creates an [CreateRoutineScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const CreateRoutineScreen({
    required CreateRoutineViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final CreateRoutineViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).createRoutine)),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).addExercises),
        onPressed: () async {
          // Get the selected exercise IDs from the exercise addition screen.
          final selectedExerciseIds =
              await Navigator.of(
                context,
                rootNavigator: true,
              ).push(
                MaterialPageRoute<UnmodifiableSetView<String>>(
                  fullscreenDialog: true,
                  builder: (context) {
                    final viewModel = AddExercisesViewModel(
                      exerciseRepository: context.read(),
                    );
                    // No need to wait for load command to finish.
                    // ignore: discarded_futures
                    viewModel.load.run();
                    return AddExercisesScreen(viewModel: viewModel);
                  },
                ),
              );
          // No need to wait for add command to finish.
          // ignore: unawaited_futures
          _viewModel.addExercises.run(selectedExerciseIds);
        },
      ),
      body:
          // Listen to the view model's add exercises command.
          ListenableBuilder(
            listenable: _viewModel.addExercises,
            builder: (_, _) => ListView.builder(
              itemBuilder: (_, index) => ListTile(
                title: Text(
                  _viewModel.routine.routineExercises[index].exercise.title,
                ),
              ),
              itemCount: _viewModel.routine.routineExercises.length,
            ),
          ),
    );
  }
}
