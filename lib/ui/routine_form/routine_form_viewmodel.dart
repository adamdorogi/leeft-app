import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:relift/data/repositories/exercise/exercise_repository.dart';
import 'package:relift/data/repositories/routine/routine_repository.dart';
import 'package:relift/domain/models/exercise/exercise.dart';
import 'package:relift/domain/models/exercise_set/exercise_set.dart';
import 'package:relift/domain/models/routine/routine.dart';
import 'package:relift/domain/models/routine_exercise/routine_exercise.dart';
import 'package:relift/utils/command.dart';
import 'package:relift/utils/result.dart';

/// A view model for managing the UI state of the routine creation and routine
/// editing screen.
class RoutineFormViewModel extends ChangeNotifier {
  /// Creates a [RoutineFormViewModel] with an [exerciseRepository].
  ///
  /// The [exerciseRepository] retrieves the exercises and stores the routine.
  RoutineFormViewModel({
    required ExerciseRepository exerciseRepository,
    required RoutineRepository routineRepository,
  }) : _exerciseRepository = exerciseRepository,
       _routineRepository = routineRepository;

  final ExerciseRepository _exerciseRepository;
  final RoutineRepository _routineRepository;

  final _log = Logger((RoutineFormViewModel).toString());

  /// The routine exercises and their corresponding exercises.
  UnmodifiableListView<(RoutineExercise, Exercise)>
  get mappedRoutineExercises => UnmodifiableListView(_mappedRoutineExercises);
  List<(RoutineExercise, Exercise)> _mappedRoutineExercises = [];

  /// The routine name.
  String? name;

  /// The routine ID.
  int? id;

  Future<List<(RoutineExercise, Exercise)>> _mapRoutineExercises(
    List<RoutineExercise> routineExercises,
  ) async {
    // Filter routine exercises with a null exercise ID.
    final validRoutineExercises = routineExercises.where(
      (routineExercise) => routineExercise.exerciseId != null,
    );

    // The routine exercises and their corresponding exercise results.
    final mappedRoutineExerciseResults = await Future.wait(
      validRoutineExercises.map(
        (routineExercise) async => (
          routineExercise,
          await _exerciseRepository.exerciseWith(
            routineExercise.exerciseId!,
          ),
        ),
      ),
    );

    // The routine exercises and their corresponding successful exercise
    // results.
    final mappedRoutineExercises = mappedRoutineExerciseResults
        .whereType<(RoutineExercise, Success<Exercise>)>()
        .map(
          (addedExerciseResult) =>
              (addedExerciseResult.$1, addedExerciseResult.$2.value),
        )
        .toList();

    return mappedRoutineExercises;
  }

  /// The command to load the routine and its exercises.
  late final Command1<void, int?> load = Command1(_load);
  Future<Result<void>> _load(int? routineId) async {
    if (routineId == null) {
      // No routine needs to be loaded, new routine is being created.
      return const Result.success(null);
    }

    final routines = await _routineRepository.routine(routineId);

    switch (routines) {
      case Success(value: final routine):
        if (routine == null) {
          return const Result.success(null);
        }
        name = routine.name;
        id = routine.id;
        _mappedRoutineExercises = await _mapRoutineExercises(
          routine.routineExercises,
        );
        _log.info('Successfully loaded routine $routineId.');
        return const Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to load routine: $error');
        return Result.failure(error);
    }
  }

  /// The command to load the exercises from the exercise repository and add it
  /// to the routine.
  late final Command1<void, UnmodifiableSetView<String>?> addExercises =
      Command1(_addExercisesIds);
  Future<Result<void>> _addExercisesIds(
    UnmodifiableSetView<String>? exerciseIds,
  ) async {
    if (exerciseIds == null || exerciseIds.isEmpty) {
      return const Result.success(null);
    }
    _log.info('Adding ${exerciseIds.length} exercises to routine...');

    final routineExercises = exerciseIds
        .map(
          (exerciseId) => RoutineExercise(
            exerciseId: exerciseId,
            sets: [
              // TODO: Number of sets from previous log entry for exercise, default to 3.
              const ExerciseSet(rest: 90),
              const ExerciseSet(rest: 90),
              const ExerciseSet(rest: 90),
            ],
          ),
        )
        .toList();
    _mappedRoutineExercises += await _mapRoutineExercises(routineExercises);
    _log.info('Successfully added ${exerciseIds.length} exercises to routine.');
    return const Result.success(null);
  }

  /// The command to save the routine.
  late final Command0<int> saveRoutine = Command0(_saveRoutine);
  Future<Result<int>> _saveRoutine() async {
    _log.info('Saving routine...');
    var routineName = name?.trim();
    if (routineName?.isEmpty ?? true) {
      routineName = null;
    }
    var routine = Routine(
      name: routineName,
      routineExercises: _mappedRoutineExercises
          .map((routineExercise) => routineExercise.$1)
          .toList(),
    );
    final routineId = id;
    if (routineId != null) {
      routine = routine.copyWith(id: routineId);
    }

    final result = await _routineRepository.saveRoutine(routine);
    switch (result) {
      case Success(value: final routineId):
        _log.info('Successfully saved routine $routineId.');
        return Result.success(routineId);
      case Failure(:final error):
        _log.warning('Failed to save routine: $error');
        return Result.failure(error);
    }
  }

  /// Adds a set to the exercise with the [exerciseIndex] in the routine.
  void addSetTo(int exerciseIndex) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    _mappedRoutineExercises[exerciseIndex] = (
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
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    _mappedRoutineExercises[exerciseIndex] = (
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
      final (routineExercise, _) = _mappedRoutineExercises[exerciseIndex];
      final (previousRoutineExercise, previousExercise) =
          _mappedRoutineExercises[exerciseIndex - 1];
      if (previousRoutineExercise.shouldSupersetWithNext &&
          !routineExercise.shouldSupersetWithNext) {
        _mappedRoutineExercises[exerciseIndex - 1] = (
          previousRoutineExercise.copyWith(shouldSupersetWithNext: false),
          previousExercise,
        );
      }
    }
    _mappedRoutineExercises.removeAt(exerciseIndex);
    notifyListeners();
  }

  /// Toggles the superset flag for the exercise with the [exerciseIndex] in the
  /// routine.
  void toggleSupersetFor(int exerciseIndex) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(
        shouldSupersetWithNext: !routineExercise.shouldSupersetWithNext,
      ),
      exercise,
    );
    notifyListeners();
  }

  /// Toggles the warm up flag for the set with the [setIndex] in the exercise
  /// with the [exerciseIndex].
  void toggleWarmUpSetFor(int exerciseIndex, int setIndex) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    final sets = routineExercise.sets.toList();
    sets[setIndex] = sets[setIndex].copyWith(
      isWarmUp: !sets[setIndex].isWarmUp,
    );
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(sets: sets),
      exercise,
    );
    notifyListeners();
  }

  /// Set the [notes] for the exercise with the [exerciseIndex].
  void setNotesFor(int exerciseIndex, String notes) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(notes: notes),
      exercise,
    );
  }

  /// Set the [weight] for the set with the [setIndex] in the exercise with the
  /// [exerciseIndex].
  void setWeightFor(int exerciseIndex, int setIndex, String weight) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    final sets = routineExercise.sets.toList();
    sets[setIndex] = sets[setIndex].copyWith(
      weight: double.tryParse(weight),
    );
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(sets: sets),
      exercise,
    );
  }

  /// Set the [reps] for the set with the [setIndex] in the exercise with the
  /// [exerciseIndex].
  void setRepsFor(int exerciseIndex, int setIndex, String reps) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    final sets = routineExercise.sets.toList();
    sets[setIndex] = sets[setIndex].copyWith(
      reps: int.tryParse(reps),
    );
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(sets: sets),
      exercise,
    );
  }

  /// Set the [rest] for the set with the [setIndex] in the exercise with the
  /// [exerciseIndex].
  void setRestFor(int exerciseIndex, int setIndex, String rest) {
    final (routineExercise, exercise) = _mappedRoutineExercises[exerciseIndex];
    final sets = routineExercise.sets.toList();
    sets[setIndex] = sets[setIndex].copyWith(
      rest: int.tryParse(rest) ?? 0,
    );
    _mappedRoutineExercises[exerciseIndex] = (
      routineExercise.copyWith(sets: sets),
      exercise,
    );
  }
}
