import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/utils/result.dart';

/// A screen for adding exercises to a routine during routine creation.
class AddExercisesScreen extends StatelessWidget {
  /// Creates an [AddExercisesScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const AddExercisesScreen({
    required AddExercisesViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final AddExercisesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addExercises),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () =>
                // Return the selected exercise IDs on pop.
                Navigator.of(context).pop(_viewModel.selectedExerciseIds),
          ),
        ],
      ),
      body:
          // Listen to the view model's load command.
          ListenableBuilder(
            listenable: _viewModel.load,
            builder: (_, child) {
              // View model is loading.
              if (_viewModel.load.isRunning) {
                return const Center(child: Text('Loading'));
              }

              // View model failed to load.
              final loadResult = _viewModel.load.result;
              if (loadResult is Failure<Null>) {
                return Center(child: Text('Error: ${loadResult.error}'));
              }

              // View model has loaded successfully.
              return child!;
            },
            child:
                // Listen to the view model for changes in selection.
                ListenableBuilder(
                  listenable: _viewModel,
                  builder: (_, _) =>
                      // Display the list of exercises.
                      ListView.builder(
                        itemBuilder: (_, index) {
                          final exercise = _viewModel.exercises[index];
                          final thumbnailBytes =
                              _viewModel.thumbnailBytes[exercise.id];

                          return CheckboxListTile(
                            title: Text(exercise.title),
                            value: _viewModel.isSelected(exercise.id),
                            onChanged: (_) =>
                                _viewModel.toggleSelectionFor(exercise.id),
                            secondary: thumbnailBytes != null
                                ? Image.memory(thumbnailBytes)
                                : const Icon(Icons.error),
                          );
                        },
                        itemCount: _viewModel.exercises.length,
                      ),
                ),
          ),
    );
  }
}
