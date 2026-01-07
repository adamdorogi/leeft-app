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
        _searchResults = exercises;
        _equipment = exercises.map((exercise) => exercise.equipment).toSet();
        _muscleGroups = exercises
            .map((exercise) => exercise.muscleGroup)
            .toSet();
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

  /// The exercises filtered based on the search query for the given
  /// [localeName], the [selectedMuscleGroups], and the [selectedEquipment].
  void setSearchResults(
    String searchQuery,
    String localeName,
  ) {
    Iterable<Exercise> result = _exercises;
    if (searchQuery.isNotEmpty) {
      result = result.where(
        (exercise) => exercise.title
            .forLocale(localeName)
            .toLowerCase()
            .contains(searchQuery.toLowerCase()),
      );
    }
    if (_selectedEquipment.isNotEmpty) {
      result = result.where(
        (exercise) => _selectedEquipment.contains(exercise.equipment),
      );
    }
    if (_selectedMuscleGroups.isNotEmpty) {
      result = result.where(
        (exercise) => _selectedMuscleGroups.contains(exercise.muscleGroup),
      );
    }
    _searchResults = result.toList();
    notifyListeners();
  }

  /// The results of [setSearchResults].
  UnmodifiableListView<Exercise> get searchResults =>
      UnmodifiableListView(_searchResults);
  List<Exercise> _searchResults = [];

  /// The map of exercise IDs to exercise thumbnail bytes.
  UnmodifiableMapView<String, Uint8List?> get thumbnailBytes =>
      UnmodifiableMapView(_thumbnailBytes);
  Map<String, Uint8List?> _thumbnailBytes = {};

  /// The muscle groups.
  UnmodifiableSetView<String> get muscleGroups =>
      UnmodifiableSetView(_muscleGroups);
  Set<String> _muscleGroups = {};

  /// The selected muscle groups.
  UnmodifiableSetView<String> get selectedMuscleGroups =>
      UnmodifiableSetView(_selectedMuscleGroups);
  final Set<String> _selectedMuscleGroups = {};

  /// Selects or unselects the [muscleGroup] filter to be used in
  /// [setSearchResults].
  void toggleMuscleGroupSelectionFor(String muscleGroup) {
    isMuscleGroupSelected(muscleGroup)
        ? _selectedMuscleGroups.remove(muscleGroup)
        : _selectedMuscleGroups.add(muscleGroup);
    notifyListeners();
  }

  /// Whether the [muscleGroup] filter is selected.
  bool isMuscleGroupSelected(String muscleGroup) =>
      _selectedMuscleGroups.contains(muscleGroup);

  /// The equipment.
  UnmodifiableSetView<String> get equipment => UnmodifiableSetView(_equipment);
  Set<String> _equipment = {};

  /// The selected equipment.
  UnmodifiableSetView<String> get selectedEquipment =>
      UnmodifiableSetView(_selectedEquipment);
  final Set<String> _selectedEquipment = {};

  /// Selects or unselects the [equipment] filter to be used in
  /// [setSearchResults].
  void toggleEquipmentSelectionFor(String equipment) {
    isEquipmentSelected(equipment)
        ? _selectedEquipment.remove(equipment)
        : _selectedEquipment.add(equipment);
    notifyListeners();
  }

  /// Whether the [equipment] filter is selected.
  bool isEquipmentSelected(String equipment) =>
      _selectedEquipment.contains(equipment);

  List<Exercise> _exercises = [];

  /// The selected exercises' IDs.
  UnmodifiableSetView<String> get selectedExerciseIds =>
      UnmodifiableSetView(_selectedExerciseIds);
  final Set<String> _selectedExerciseIds = {};

  /// Selects or unselects the [exerciseId].
  void toggleExerciseIdSelectionFor(String exerciseId) {
    isExerciseIdSelected(exerciseId)
        ? _selectedExerciseIds.remove(exerciseId)
        : _selectedExerciseIds.add(exerciseId);
    notifyListeners();
  }

  /// Whether the [exerciseId] is selected.
  bool isExerciseIdSelected(String exerciseId) =>
      _selectedExerciseIds.contains(exerciseId);
}
