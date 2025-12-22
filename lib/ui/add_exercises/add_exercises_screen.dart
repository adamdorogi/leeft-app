import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/utils/result.dart';

import 'package:shimmer/shimmer.dart';

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
          // Listen to the view model and its load command.
          ListenableBuilder(
            listenable: Listenable.merge([_viewModel, _viewModel.load]),
            builder: (_, child) {
              if (_viewModel.load.result is Success<Null>) {
                // View model has loaded successfully, display the list of
                // exercises.
                return ListView.builder(
                  itemBuilder: (_, index) {
                    final exercise = _viewModel.exercises[index];
                    final thumbnailBytes =
                        _viewModel.thumbnailBytes[exercise.id];

                    return ListTile(
                      title: Text(
                        exercise.title.forLocale(
                          AppLocalizations.of(context).localeName,
                        ),
                      ),
                      selected: _viewModel.isSelected(exercise.id),
                      onTap: () => _viewModel.toggleSelectionFor(exercise.id),
                      selectedTileColor: Theme.of(context).highlightColor,
                      leading: thumbnailBytes != null
                          ? CircleAvatar(
                              foregroundImage: MemoryImage(thumbnailBytes),
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.fitness_center),
                            ),
                      trailing: IconButton(
                        onPressed: () => (),
                        icon: const Icon(Icons.info_outline),
                      ),
                    );
                  },
                  itemCount: _viewModel.exercises.length,
                );
              }

              // View model is loading or has failed to load, display
              // skeletonized list.
              return child!;
            },
            child: ListView.builder(
              itemBuilder: (_, _) => Shimmer.fromColors(
                baseColor: Theme.of(context).highlightColor,
                highlightColor: Theme.of(context).splashColor,
                child: ListTile(
                  title: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: .circular(8),
                      color: Colors.white,
                    ),
                    child: const SizedBox(height: 16),
                  ),
                  leading: const CircleAvatar(),
                ),
              ),
            ),
          ),
    );
  }
}
