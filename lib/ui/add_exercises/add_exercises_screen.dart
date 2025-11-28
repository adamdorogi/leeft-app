import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';

/// A screen for adding exercises to a routine during routine creation.
class AddExercisesScreen extends StatelessWidget {
  /// Creates an [AddExercisesScreen].
  const AddExercisesScreen({super.key, required this.viewModel});

  /// The view model for managing the UI state of this screen.
  final AddExercisesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addExercises),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () =>
                Navigator.of(context).pop(viewModel.selectedExercises),
          ),
        ],
      ),
      body:
          // Listen to the view model's load command.
          ListenableBuilder(
            listenable: viewModel.load,
            builder: (_, child) {
              if (viewModel.load.value.isFailure) {
                return const Center(child: Text('Error'));
              }

              if (viewModel.load.value.isRunning) {
                return const Center(child: Text('Loading'));
              }

              return child!;
            },
            child:
                // Listen for state changes in the view model, built only once.
                ListenableBuilder(
                  listenable: viewModel,
                  builder: (_, _) => ListView.builder(
                    itemBuilder: (_, index) {
                      // Display the list of exercises.
                      final exercise = viewModel.exercises[index];
                      final image = viewModel.thumbnails[exercise.id];
                      return CheckboxListTile(
                        title: Text(exercise.title),
                        value: viewModel.selectedExercises.contains(exercise),
                        onChanged: (_) =>
                            viewModel.toggleExerciseSelection(exercise),
                        secondary: image != null
                            ? Image.memory(image)
                            : const CircularProgressIndicator(),
                      );
                    },
                    itemCount: viewModel.exercises.length,
                  ),
                ),
          ),
    );
  }
}
