import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/add_exercises/add_exercises_screen.dart';
import 'package:relift/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:relift/ui/core/widgets/exercise_thumbnail.dart';
import 'package:relift/ui/exercise_details/exercise_details_screen.dart';
import 'package:relift/ui/exercise_details/exercise_details_viewmodel.dart';
import 'package:relift/ui/routine_form/routine_form_viewmodel.dart';
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
    return ListenableBuilder(
      listenable: Listenable.merge([
        _viewModel,
        _viewModel.saveRoutine,
        _viewModel.addExercises,
        _viewModel.load,
      ]),
      builder: (context, _) => Scaffold(
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                _viewModel.id == null
                    ? AppLocalizations.of(context).createRoutine
                    : AppLocalizations.of(context).editRoutine,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed:
                      _viewModel.mappedRoutineExercises.isNotEmpty &&
                          !_viewModel.saveRoutine.isRunning
                      ? () async {
                          await _viewModel.saveRoutine.run();
                          if (_viewModel.saveRoutine.result is Success<int> &&
                              context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      : null,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: _viewModel.name,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).newRoutine,
                ),
                onChanged: (name) => _viewModel.name = name,
              ),
            ),
            SliverList.builder(
              itemBuilder: (_, index) {
                final (routineExercise, exercise) =
                    _viewModel.mappedRoutineExercises[index];
                final thumbnailUrl = exercise.thumbnailUrl;

                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: ExerciseThumbnail(thumbnailUrl: thumbnailUrl),
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
                                      // No need to wait for load command
                                      // to finish.
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
                              child: Text(
                                AppLocalizations.of(context).remove,
                              ),
                            ),
                            MenuItemButton(
                              leadingIcon: const Icon(Icons.swap_horiz),
                              child: Text(
                                AppLocalizations.of(context).replace,
                              ),
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
                            label: Text(
                              AppLocalizations.of(context).addSet,
                            ),
                            icon: const Icon(Icons.add),
                            onPressed: () => _viewModel.addSetTo(index),
                          ),
                          if (index <
                              _viewModel.mappedRoutineExercises.length - 1)
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
              itemCount: _viewModel.mappedRoutineExercises.length,
            ),
          ],
        ),
      ),
    );
  }
}
