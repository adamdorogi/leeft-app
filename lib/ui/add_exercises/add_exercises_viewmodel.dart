import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the exercise addition screen.
class AddExercisesViewModel extends ChangeNotifier {
  /// Creates an [AddExercisesViewModel] with an [exerciseRepository].
  ///
  /// The [exerciseRepository] retrieves the exercises and exercise thumbnail
  /// bytes.
  AddExercisesViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository;

  final ExerciseRepository _exerciseRepository;

  final _log = Logger((AddExercisesViewModel).toString());

  /// The exercises.
  UnmodifiableListView<Exercise> get exercises =>
      UnmodifiableListView(_exercises);
  List<Exercise> _exercises = [];

  /// The map of exercise IDs to exercise thumbnail bytes.
  UnmodifiableMapView<String, Uint8List?> get thumbnailBytes =>
      UnmodifiableMapView(_thumbnailBytes);
  Map<String, Uint8List?> _thumbnailBytes = {};

  /// The command to load the exercises and exercise thumbnail bytes from the
  /// exercise repository.
  late final Command0<Null> load = Command0(
    _load,
  );
  Future<Result<Null>> _load() async {
    _log.info('Loading view model...');
    final exercisesResult = await _exerciseRepository.exercises;
    switch (exercisesResult) {
      case Success(value: final exercises):
        _exercises = exercises;
        final exerciseIds = exercises.map((exercise) => exercise.id);
        final thumbnailBytesFutures = exercises.map(
          (exercise) => _exerciseRepository.thumbnailBytesFor(exercise.id),
        );
        final thumbnailBytesResult = await Future.wait(thumbnailBytesFutures);
        final thumbnailBytes = thumbnailBytesResult.map(
          (result) => result is Success<Uint8List> ? result.value : null,
        );
        _thumbnailBytes = Map.fromIterables(exerciseIds, thumbnailBytes);
        _log.info('Successfully loaded view model.');
        return Result.success(null);
      case Failure(:final error):
        _log.info('Failed to load view model: $error');
        return Result.failure(error);
    }
  }

  /// The selected exercises' IDs.
  UnmodifiableSetView<String> get selectedExerciseIds =>
      UnmodifiableSetView(_selectedExerciseIds);
  final Set<String> _selectedExerciseIds = {};

  /// Selects or unselects the [exerciseId].
  void toggleSelectionFor(String exerciseId) {
    isSelected(exerciseId)
        ? _selectedExerciseIds.remove(exerciseId)
        : _selectedExerciseIds.add(exerciseId);
    notifyListeners();
  }

  /// Whether the [exerciseId] is selected.
  bool isSelected(String exerciseId) =>
      _selectedExerciseIds.contains(exerciseId);
}
