import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';

/// A view model for managing the UI state of the Add Exercises screen.
class AddExercisesViewModel extends ChangeNotifier {
  /// Creates an [AddExercisesViewModel].
  ///
  /// The [exerciseRepository] is used to manage exercise data.
  AddExercisesViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository {
    load = Command0(_load);
    unawaited(load.execute());
  }

  final ExerciseRepository _exerciseRepository;

  /// The exercise options.
  UnmodifiableListView<Exercise> get exercises =>
      UnmodifiableListView(_exercises);
  List<Exercise> _exercises = [];

  /// The selected exercises.
  UnmodifiableSetView<Exercise> get selectedExercises =>
      UnmodifiableSetView(_selectedExercises);
  final Set<Exercise> _selectedExercises = {};

  /// Load the exercise data from the exercise repository.
  late Command0<Unit> load;

  AsyncResult<Unit> _load() async {
    final exercisesResult = await _exerciseRepository.exercises;
    _exercises = exercisesResult.getOrDefault(_exercises);
    return exercisesResult.pure(unit);
  }

  /// Selects or unselects the [exercise].
  void toggleExerciseSelection(Exercise exercise) {
    _selectedExercises.contains(exercise)
        ? _selectedExercises.remove(exercise)
        : _selectedExercises.add(exercise);
    notifyListeners();
  }
}
