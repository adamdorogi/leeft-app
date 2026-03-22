import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/add_exercises/add_exercises_screen.dart';
import 'package:relift/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:relift/ui/core/widgets/app_sliver_app_bar.dart';
import 'package:relift/ui/exercise_details/exercise_details_screen.dart';
import 'package:relift/ui/exercise_details/exercise_details_viewmodel.dart';
import 'package:relift/ui/routine_form/routine_form_viewmodel.dart';
import 'package:relift/ui/routine_form/widgets/routine_exercise_card.dart';
import 'package:relift/utils/result.dart';

/// A screen for creating and editing routines.
class RoutineFormScreen extends StatelessWidget {
  /// Creates a [RoutineFormScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const RoutineFormScreen({
    required RoutineFormViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final RoutineFormViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListenableBuilder(
        listenable: Listenable.merge([
          _viewModel,
          _viewModel.saveRoutine,
          _viewModel.addExercises,
          _viewModel.load,
        ]),
        builder: (context, _) => CustomScrollView(
          slivers: [
            // App bar.
            AppSliverAppBar(
              title: Text(
                _viewModel.id == null
                    ? AppLocalizations.of(context).createRoutine
                    : AppLocalizations.of(context).editRoutine,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed:
                      _viewModel.mappedRoutineExercises.isEmpty ||
                          _viewModel.saveRoutine.isRunning
                      ? null
                      : () async {
                          await _viewModel.saveRoutine.run();
                          if (_viewModel.saveRoutine.result is Success<int> &&
                              context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                ),
              ],
            ),
            // Routine name text field.
            if (_viewModel.load.result is Success<void>)
              SliverToBoxAdapter(
                child: TextFormField(
                  initialValue: _viewModel.name,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).unnamedRoutine,
                  ),
                  onChanged: (name) => _viewModel.name = name,
                ),
              ),
            // Routine exercises.
            SliverList.builder(
              itemCount: _viewModel.mappedRoutineExercises.length,
              findChildIndexCallback: (key) {
                final routineId = (key as ValueKey).value as String?;
                final index = _viewModel.mappedRoutineExercises.indexWhere(
                  (mappedRoutineExercise) =>
                      mappedRoutineExercise.routineExercise.id == routineId,
                );
                return index == -1 ? null : index;
              },
              itemBuilder: (context, index) {
                final (:routineExercise, :exercise) =
                    _viewModel.mappedRoutineExercises[index];

                return RoutineExerciseCard(
                  key: ValueKey(routineExercise.id),
                  exercise: exercise,
                  routineExercise: routineExercise,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) {
                          final viewModel = ExerciseDetailsViewModel(
                            exerciseRepository: context.read(),
                          );
                          // No need to wait for load command to finish.
                          // ignore: discarded_futures
                          viewModel.load.run(exercise.id);
                          // No need to wait for load command to finish.
                          // ignore: discarded_futures
                          viewModel.loadMedia.run(exercise.mediaUrl);
                          return ExerciseDetailsScreen(
                            viewModel: viewModel,
                          );
                        },
                      ),
                    );
                  },
                  onRemove: () => _viewModel.removeExercise(index),
                  onReplace: () => (),
                  onNotesChanged: (notes) =>
                      _viewModel.setNotesFor(index, notes),
                  onSetDismissed: (setIndex) =>
                      _viewModel.removeSetFrom(index, setIndex),
                  onSetWeightChanged: (setIndex, weight) =>
                      _viewModel.setWeightFor(index, setIndex, weight),
                  onSetRepsChanged: (setIndex, reps) =>
                      _viewModel.setRepsFor(index, setIndex, reps),
                  onSetRestChanged: (setIndex, rest) =>
                      _viewModel.setRestFor(index, setIndex, rest),
                  onToggleWarmUpSet: (setIndex) =>
                      _viewModel.toggleWarmUpSetFor(index, setIndex),
                  onAddSet: () => _viewModel.addSetTo(index),
                  onToggleSuperset:
                      index == _viewModel.mappedRoutineExercises.length - 1
                      ? null
                      : () => _viewModel.toggleSupersetFor(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
