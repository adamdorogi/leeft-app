import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/domain/models/routine_exercise/routine_exercise.dart';

/// A view model for managing the UI state of the Create Routine screen.
class CreateRoutineViewModel extends ChangeNotifier {
  /// Creates a [CreateRoutineViewModel].
  CreateRoutineViewModel();

  /// The routine being created.
  Routine get routine => _routine;
  Routine _routine = const Routine(id: 'id', name: 'New Routine');

  /// Adds the [exercises] to the routine.
  void addExercises(UnmodifiableSetView<Exercise>? exercises) {
    if (exercises == null || exercises.isEmpty) {
      return;
    }
    final routineExercises = exercises
        .map((exercise) => RoutineExercise(exercise: exercise))
        .toList();
    final newRoutineExercises = _routine.routineExercises + routineExercises;
    _routine = _routine.copyWith(routineExercises: newRoutineExercises);
    notifyListeners();
  }
}
