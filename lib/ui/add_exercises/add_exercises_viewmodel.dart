import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';

class AddExercisesViewModel extends ChangeNotifier {
  AddExercisesViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository {
    load = Command0(_load)..execute();
  }

  final ExerciseRepository _exerciseRepository;

  List<Exercise> _exercises = [];

  UnmodifiableListView<Exercise> get exercises =>
      UnmodifiableListView(_exercises);

  final Set<String> _selectedExerciseIds = {};

  UnmodifiableSetView<String> get selectedExerciseIds =>
      UnmodifiableSetView(_selectedExerciseIds);

  late Command0<Unit> load;

  AsyncResult<Unit> _load() async {
    final result = await _exerciseRepository.exercises;
    switch (result) {
      case Success():
        _exercises = result.getOrNull();
        return const Success(unit);
      case Failure():
        final exception = result.exceptionOrNull();
        return Failure(exception);
    }
  }

  void toggleExerciseIdSelection(String exerciseId) {
    _selectedExerciseIds.contains(exerciseId)
        ? _selectedExerciseIds.remove(exerciseId)
        : _selectedExerciseIds.add(exerciseId);

    notifyListeners();
  }
}
