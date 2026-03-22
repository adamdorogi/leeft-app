import 'package:flutter/material.dart';

import 'package:relift/domain/models/exercise/exercise.dart';
import 'package:relift/domain/models/routine_exercise/routine_exercise.dart';
import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/core/widgets/exercise_thumbnail.dart';
import 'package:relift/ui/core/widgets/routine_exercise_options_menu.dart';

/// A card for displaying a routine exercise.
class RoutineExerciseCard extends StatelessWidget {
  /// Creates a [RoutineExerciseCard].
  const RoutineExerciseCard({
    required this.exercise,
    required this.routineExercise,
    required this.onTap,
    required this.onRemove,
    required this.onReplace,
    required this.onNotesChanged,
    required this.onToggleWarmUpSet,
    required this.onSetWeightChanged,
    required this.onSetRepsChanged,
    required this.onSetRestChanged,
    required this.onSetDismissed,
    required this.onAddSet,
    this.onToggleSuperset,
    super.key,
  });

  /// The exercise to display.
  final Exercise exercise;

  /// The routine exercise to display.
  final RoutineExercise routineExercise;

  /// Callback to navigate to exercise details screen.
  final void Function() onTap;

  /// Callback to remove this exercise from the routine.
  final void Function() onRemove;

  /// Callback to replace this exercise in the routine.
  final void Function() onReplace;

  /// Callback to retrieve notes on change.
  final void Function(String) onNotesChanged;

  /// Callback to toggle warm-up set status.
  final void Function(int) onToggleWarmUpSet;

  /// Callback to update a set's weight value.
  final void Function(int, String) onSetWeightChanged;

  /// Callback to update a set's reps value.
  final void Function(int, String) onSetRepsChanged;

  /// Callback to update a set's rest duration.
  final void Function(int, String) onSetRestChanged;

  /// Callback to remove a set when dismissed.
  final void Function(int) onSetDismissed;

  /// Callback to add a new set.
  final void Function() onAddSet;

  /// Callback to toggle superset status for this exercise.
  final void Function()? onToggleSuperset;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: .hardEdge,
      child: Column(
        children: [
          // Exercise details.
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    // Exercise thumbnail.
                    ExerciseThumbnail(thumbnailUrl: exercise.thumbnailUrl),
                    //Exercise title.
                    Text(
                      exercise.title.forLocale(
                        AppLocalizations.of(context).localeName,
                      ),
                    ),
                  ],
                ),
                // Options menu.
                RoutineExerciseOptionsMenu(
                  onReplace: onReplace,
                  onRemove: onRemove,
                ),
              ],
            ),
          ),
          // Notes.
          TextFormField(
            initialValue: routineExercise.notes,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).notes,
            ),
            onChanged: onNotesChanged,
          ),
          for (var i = 0; i < routineExercise.sets.length; i++)
            Dismissible(
              key: ValueKey(routineExercise.sets[i].id),
              direction: .endToStart,
              onDismissed: (_) => onSetDismissed(i),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onToggleWarmUpSet(i),
                        icon: routineExercise.sets[i].isWarmUp
                            ? const Icon(Icons.fireplace)
                            : Text('${i + 1}.'),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: routineExercise.sets[i].weight == null
                              ? null
                              : '${routineExercise.sets[i].weight}',
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            ).kg,
                          ),
                          onChanged: (weight) => onSetWeightChanged(i, weight),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: routineExercise.sets[i].reps == null
                              ? null
                              : '${routineExercise.sets[i].reps}',
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            ).reps,
                          ),
                          onChanged: (reps) => onSetRepsChanged(i, reps),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '${routineExercise.sets[i].rest}',
                          onChanged: (rest) => onSetRestChanged(i, rest),
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
                onPressed: onAddSet,
              ),
              if (onToggleSuperset != null)
                ElevatedButton.icon(
                  label: Text(
                    AppLocalizations.of(context).superset,
                  ),
                  icon: Icon(
                    routineExercise.shouldSupersetWithNext
                        ? Icons.link
                        : Icons.link_off,
                  ),
                  onPressed: onToggleSuperset,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
