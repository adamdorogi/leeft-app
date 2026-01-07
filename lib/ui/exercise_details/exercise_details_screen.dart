import 'package:flutter/material.dart';
import 'package:leeft/l10n/app_localizations.dart';

import 'package:leeft/ui/exercise_details/exercise_details_viewmodel.dart';

/// A screen for viewing exercise details.
class ExerciseDetailsScreen extends StatelessWidget {
  /// Creates an [ExerciseDetailsScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const ExerciseDetailsScreen({
    required ExerciseDetailsViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final ExerciseDetailsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel.load,
      builder: (_, _) {
        final exercise = _viewModel.exercise;
        if (exercise == null) {
          // Exercise hasn't been loaded yet.
          return Scaffold(
            appBar: AppBar(),
          );
        }
        // Exercise has been loaded.
        return Scaffold(
          appBar: AppBar(
            title: Text(
              exercise.title.forLocale(AppLocalizations.of(context).localeName),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 10,
                  children: [
                    // Exercise equipment.
                    Chip(
                      avatar: const Icon(Icons.fitness_center),
                      label: Text(
                        AppLocalizations.of(
                          context,
                        ).equipmentNameFor(exercise.equipment),
                      ),
                    ),
                    // Primary muscle group.
                    Chip(
                      avatar: const Icon(Icons.looks_one),
                      label: Text(
                        AppLocalizations.of(
                          context,
                        ).muscleGroupNameFor(exercise.muscleGroup),
                      ),
                    ),
                    // Secondary muscle groups.
                    for (final muscleGroup in exercise.otherMuscles)
                      Chip(
                        avatar: const Icon(Icons.looks_two),
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).muscleGroupNameFor(muscleGroup),
                        ),
                      ),
                  ],
                ),
              ),
              // Instructions.
              for (final (i, instruction)
                  in exercise.instructions
                      .forLocale(AppLocalizations.of(context).localeName)
                      .indexed)
                ListTile(
                  leading: Text('${i + 1}.'),
                  title: Text(instruction),
                ),
            ],
          ),
        );
      },
    );
  }
}
