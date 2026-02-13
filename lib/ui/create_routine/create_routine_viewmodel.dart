import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/domain/models/exercise_set/exercise_set.dart';
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

  /// The routine exercises and their corresponding exercises.
  UnmodifiableListView<(RoutineExercise, Exercise)> get addedExercises =>
      UnmodifiableListView(_addedExercises);
  List<(RoutineExercise, Exercise)> _addedExercises = [];

  /// The command to load the exercises from the exercise repository and add it
  /// to the routine.
  late final Command1<void, UnmodifiableSetView<String>?> addExercises =
      Command1(_addExercisesIds);
  Future<Result<void>> _addExercisesIds(
    UnmodifiableSetView<String>? exerciseIds,
  ) async {
    if (exerciseIds == null || exerciseIds.isEmpty) {
      return Result.success(null);
    }
    _log.info('Adding ${exerciseIds.length} exercises to routine...');
    final addedExercisesResults = await Future.wait(
      exerciseIds.map(
        (exerciseId) async => (
          RoutineExercise(
            exerciseId: exerciseId,
            sets: [
              // TODO: Number of sets from previous log entry for exercise, default to 3.
              const ExerciseSet(rest: 90),
              const ExerciseSet(rest: 90),
              const ExerciseSet(rest: 90),
            ],
          ),
          await _exerciseRepository.exerciseWith(exerciseId),
        ),
      ),
    );
    _addedExercises += addedExercisesResults
        .whereType<(RoutineExercise, Success<Exercise>)>()
        .map(
          (addedExerciseResult) =>
              (addedExerciseResult.$1, addedExerciseResult.$2.value),
        )
        .toList();
    _log.info('Successfully added ${exerciseIds.length} exercises to routine.');
    return Result.success(null);
  }

  /// Adds a set to the exercise with the [exerciseIndex] in the routine.
  void addSetTo(int exerciseIndex) {
    final routineExercise = _addedExercises[exerciseIndex].$1;
    final exercise = _addedExercises[exerciseIndex].$2;
    _addedExercises[exerciseIndex] = (
      routineExercise.copyWith(
        // TODO: Get default rest value, or rest value from previous set.
        sets: routineExercise.sets + [const ExerciseSet(rest: 90)],
      ),
      exercise,
    );
    notifyListeners();
  }

  /// Removes the set with the [setIndex] from the exercise with the
  /// [exerciseIndex] in the routine.
  void removeSetFrom(int exerciseIndex, int setIndex) {
    final routineExercise = _addedExercises[exerciseIndex].$1;
    final exercise = _addedExercises[exerciseIndex].$2;
    _addedExercises[exerciseIndex] = (
      routineExercise.copyWith(
        sets: routineExercise.sets.toList()..removeAt(setIndex),
      ),
      exercise,
    );
    notifyListeners();
  }

  /// Removes the exercise with the [exerciseIndex] from the routine.
  void removeExercise(int exerciseIndex) {
    // If exercise is the last exercise in a superset, remove superset flag from
    // the previous exercise.
    if (exerciseIndex > 0) {
      final routineExercise = _addedExercises[exerciseIndex].$1;
      final previousRoutineExercise = _addedExercises[exerciseIndex - 1].$1;
      final previousExercise = _addedExercises[exerciseIndex - 1].$2;
      if (previousRoutineExercise.shouldSupersetWithNext &&
          !routineExercise.shouldSupersetWithNext) {
        _addedExercises[exerciseIndex - 1] = (
          previousRoutineExercise.copyWith(shouldSupersetWithNext: false),
          previousExercise,
        );
      }
    }
    _addedExercises.removeAt(exerciseIndex);
    notifyListeners();
  }

  /// Toggles the superset flag for the exercise with the [exerciseIndex] in the
  /// routine.
  void toggleSupersetFor(int exerciseIndex) {
    final routineExercise = _addedExercises[exerciseIndex].$1;
    final exercise = _addedExercises[exerciseIndex].$2;
    _addedExercises[exerciseIndex] = (
      routineExercise.copyWith(
        shouldSupersetWithNext: !routineExercise.shouldSupersetWithNext,
      ),
      exercise,
    );
    notifyListeners();
  }
}
