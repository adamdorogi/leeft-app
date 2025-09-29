import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class AddExercisesViewModel extends ChangeNotifier {
  AddExercisesViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository {
    load = Command0(_load)..execute();
  }

  final ExerciseRepository _exerciseRepository;

  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

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
}
