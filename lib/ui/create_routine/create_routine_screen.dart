import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_screen.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/ui/create_routine/create_routine_viewmodel.dart';
import 'package:leeft/ui/exercise_details/exercise_details_screen.dart';
import 'package:leeft/ui/exercise_details/exercise_details_viewmodel.dart';

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
            listenable: Listenable.merge([
              _viewModel.addExercises,
              _viewModel,
            ]),
            builder: (_, _) => ListView.builder(
              itemBuilder: (_, index) {
                final (routineExercise, exercise) =
                    _viewModel.addedExercises[index];
                final thumbnailUrl = exercise.thumbnailUrl;

                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: thumbnailUrl != null
                            ? CircleAvatar(
                                foregroundImage: AssetImage(thumbnailUrl),
                              )
                            : const CircleAvatar(
                                child: Icon(Icons.fitness_center),
                              ),
                        title: Text(
                          exercise.title.forLocale(
                            AppLocalizations.of(context).localeName,
                          ),
                        ),
                        trailing: MenuAnchor(
                          builder: (_, controller, _) => IconButton(
                            onPressed: () => controller.isOpen
                                ? controller.close()
                                : controller.open(),
                            icon: const Icon(Icons.more_horiz),
                          ),
                          menuChildren: [
                            MenuItemButton(
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) {
                                      final viewModel =
                                          ExerciseDetailsViewModel(
                                            exerciseRepository: context.read(),
                                          );
                                      // No need to wait for load command to
                                      // finish.
                                      // ignore: discarded_futures
                                      viewModel.load.run(exercise.id);
                                      return ExerciseDetailsScreen(
                                        viewModel: viewModel,
                                      );
                                    },
                                  ),
                                );
                              },
                              leadingIcon: const Icon(Icons.info_outline),
                            ),
                            MenuItemButton(
                              onPressed: () => _viewModel.removeExercise(index),
                              leadingIcon: const Icon(Icons.delete),
                              child: Text(AppLocalizations.of(context).remove),
                            ),
                            MenuItemButton(
                              leadingIcon: const Icon(Icons.swap_horiz),
                              child: Text(AppLocalizations.of(context).replace),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        key: UniqueKey(),
                        initialValue: routineExercise.notes,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).notes,
                        ),
                        onChanged: (notes) =>
                            _viewModel.setNotesFor(index, notes),
                      ),
                      for (var i = 0; i < routineExercise.sets.length; i++)
                        Dismissible(
                          key: UniqueKey(),
                          direction: .endToStart,
                          onDismissed: (_) =>
                              _viewModel.removeSetFrom(index, i),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _viewModel.toggleWarmUpSetFor(index, i),
                                    icon: routineExercise.sets[i].isWarmUp
                                        ? const Icon(Icons.fireplace)
                                        : Text('${i + 1}.'),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          routineExercise.sets[i].weight == null
                                          ? null
                                          : '${routineExercise.sets[i].weight}',
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(
                                          context,
                                        ).kg,
                                      ),
                                      onChanged: (weight) => _viewModel
                                          .setWeightFor(index, i, weight),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          routineExercise.sets[i].reps == null
                                          ? null
                                          : '${routineExercise.sets[i].reps}',
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(
                                          context,
                                        ).reps,
                                      ),
                                      onChanged: (reps) =>
                                          _viewModel.setRepsFor(index, i, reps),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          '${routineExercise.sets[i].rest}',
                                      onChanged: (rest) =>
                                          _viewModel.setRestFor(index, i, rest),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          ElevatedButton.icon(
                            label: Text(AppLocalizations.of(context).addSet),
                            icon: const Icon(Icons.add),
                            onPressed: () => _viewModel.addSetTo(index),
                          ),
                          if (index < _viewModel.addedExercises.length - 1)
                            ElevatedButton.icon(
                              label: Text(
                                AppLocalizations.of(context).superset,
                              ),
                              icon: Icon(
                                routineExercise.shouldSupersetWithNext
                                    ? Icons.link
                                    : Icons.link_off,
                              ),
                              onPressed: () =>
                                  _viewModel.toggleSupersetFor(index),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: _viewModel.addedExercises.length,
            ),
          ),
    );
  }
}
