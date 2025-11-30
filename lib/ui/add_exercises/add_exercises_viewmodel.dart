import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

/// A view model for managing the UI state of the Add Exercises screen.
class AddExercisesViewModel extends ChangeNotifier {
  /// Creates an [AddExercisesViewModel].
  ///
  /// The [exerciseRepository] is used to manage exercise data.
  AddExercisesViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository {
    // ignore: discarded_futures
    load = Command0(_load)..execute();
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

  /// The exercise IDs mapped to thumbnails.
  UnmodifiableMapView<String, Uint8List> get thumbnails =>
      UnmodifiableMapView(_thumbnails);
  final Map<String, Uint8List> _thumbnails = {};

  /// Load the exercise data from the exercise repository.
  late Command0<Null> load;

  Future<Result<Null>> _load() async {
    final exercisesResult = await _exerciseRepository.exercises;
    switch (exercisesResult) {
      case Success():
        _exercises = exercisesResult.value;
        notifyListeners();
        for (final exercise in _exercises) {
          _loadThumbnailFor(exercise.id);
        }
        return Result.success(null);
      case Failure():
        return Result.failure(exercisesResult.error);
    }
  }

  void _loadThumbnailFor(String exerciseId) async {
    final thumbnailResult = await _exerciseRepository.thumbnailFor(exerciseId);
    switch (thumbnailResult) {
      case Success():
        _thumbnails[exerciseId] = thumbnailResult.value;
        notifyListeners();
      case Failure():
    }
  }

  /// Selects or unselects the [exercise].
  void toggleExerciseSelection(Exercise exercise) {
    _selectedExercises.contains(exercise)
        ? _selectedExercises.remove(exercise)
        : _selectedExercises.add(exercise);
    notifyListeners();
  }
}
