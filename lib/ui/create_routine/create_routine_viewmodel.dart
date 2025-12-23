import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/domain/models/routine_exercise/routine_exercise.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the routine creation screen.
class CreateRoutineViewModel extends ChangeNotifier {
  /// Creates a [CreateRoutineViewModel] with an [exerciseRepository].
  ///
  /// The [exerciseRepository] retrieves the exercises and stores the routine.
  CreateRoutineViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository;

  final ExerciseRepository _exerciseRepository;

  final _log = Logger((CreateRoutineViewModel).toString());

  /// The routine being created.
  Routine get routine => _routine;
  Routine _routine = const Routine(id: 'id', name: 'New Routine');

  /// The command to load the exercises from the exercise repository and add it
  /// to the [routine].
  late final Command1<Null, UnmodifiableSetView<String>?> addExercises =
      Command1(_addExercisesIds);
  Future<Result<Null>> _addExercisesIds(
    UnmodifiableSetView<String>? exerciseIds,
  ) async {
    if (exerciseIds == null || exerciseIds.isEmpty) {
      return Result.success(null);
    }
    _log.info('Adding ${exerciseIds.length} exercises to routine...');
    final exerciseResults = await Future.wait(
      exerciseIds.map(_exerciseRepository.exerciseWith),
    );
    final exercises = exerciseResults.whereType<Success<Exercise>>().map(
      (exerciseResult) => exerciseResult.value,
    );
    final routineExercises = exercises
        .map((exercise) => RoutineExercise(exercise: exercise))
        .toList();
    final newRoutineExercises = _routine.routineExercises + routineExercises;
    _routine = _routine.copyWith(routineExercises: newRoutineExercises);
    _log.info('Successfully added ${exerciseIds.length} exercises to routine.');
    return Result.success(null);
  }
}
