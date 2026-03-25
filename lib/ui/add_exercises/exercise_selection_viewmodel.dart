import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:relift/data/repositories/exercise/exercise_repository.dart';
import 'package:relift/domain/models/exercise/exercise.dart';
import 'package:relift/utils/command.dart';
import 'package:relift/utils/result.dart';

/// A view model for managing the UI state of the exercise addition screen.
class ExerciseSelectionViewModel extends ChangeNotifier {
  /// Creates an [ExerciseSelectionViewModel] with an [exerciseRepository].
  ///
  /// The [exerciseRepository] retrieves the exercises.
  ExerciseSelectionViewModel({required ExerciseRepository exerciseRepository})
    : _exerciseRepository = exerciseRepository {
    // Notify of state change when controller value changes.
    searchController.addListener(notifyListeners);
  }

  final ExerciseRepository _exerciseRepository;

  final _log = Logger((ExerciseSelectionViewModel).toString());

  /// Whether the exercise selection is for replacing an exercise in the
  /// routine.
  bool shouldReplace = false;

  /// The search text field controller.
  final searchController = TextEditingController();

  /// The command to load the exercises from the exercise repository.
  late final Command0<void> load = Command0(_load);
  Future<Result<void>> _load() async {
    _log.info('Loading view model...');
    final exercisesResult = await _exerciseRepository.exercises;

    switch (exercisesResult) {
      case Success(value: final exercises):
        _exercises = exercises;
        _equipment = exercises.map((exercise) => exercise.equipment).toSet();
        _muscleGroups = exercises
            .map((exercise) => exercise.muscleGroup)
            .toSet();
        _log.info('Successfully loaded view model.');
        return const Result.success(null);
      case Failure(:final error):
        _log.info('Failed to load view model: $error');
        return Result.failure(error);
    }
  }

  /// The exercises filtered based on the [searchController] value for the given
  /// [localeName], the [selectedMuscleGroups], and the [selectedEquipment].
  UnmodifiableListView<Exercise> filteredExercises(String localeName) {
    Iterable<Exercise> exercises = _exercises;

    // Filter title.
    final searchQuery = searchController.text;
    if (searchQuery.isNotEmpty) {
      exercises = exercises.where(
        (exercise) => exercise.title
            .forLocale(localeName)
            .toLowerCase()
            .contains(searchQuery.toLowerCase()),
      );
    }

    // Filter equipment.
    if (_selectedEquipment.isNotEmpty) {
      exercises = exercises.where(
        (exercise) => _selectedEquipment.contains(exercise.equipment),
      );
    }

    // Filter muscle groups.
    if (_selectedMuscleGroups.isNotEmpty) {
      exercises = exercises.where(
        (exercise) => _selectedMuscleGroups.contains(exercise.muscleGroup),
      );
    }

    return UnmodifiableListView(exercises);
  }

  List<Exercise> _exercises = [];

  /// The selected exercises' IDs.
  UnmodifiableSetView<String> get selectedExerciseIds =>
      UnmodifiableSetView(_selectedExerciseIds);
  final Set<String> _selectedExerciseIds = {};

  /// Selects or unselects the [exerciseId].
  void toggleExerciseIdSelectionFor(String exerciseId) {
    _selectedExerciseIds.contains(exerciseId)
        ? _selectedExerciseIds.remove(exerciseId)
        : _selectedExerciseIds.add(exerciseId);
    notifyListeners();
  }

  /// The muscle groups.
  UnmodifiableSetView<String> get muscleGroups =>
      UnmodifiableSetView(_muscleGroups);
  Set<String> _muscleGroups = {};

  /// The selected muscle groups.
  UnmodifiableSetView<String> get selectedMuscleGroups =>
      UnmodifiableSetView(_selectedMuscleGroups);
  final Set<String> _selectedMuscleGroups = {};

  /// Selects or unselects the [muscleGroup] filter.
  void toggleMuscleGroupSelectionFor(String muscleGroup) {
    _selectedMuscleGroups.contains(muscleGroup)
        ? _selectedMuscleGroups.remove(muscleGroup)
        : _selectedMuscleGroups.add(muscleGroup);
    notifyListeners();
  }

  /// Unselects all muscle groups.
  void clearSelectedMuscleGroups() {
    _selectedMuscleGroups.clear();
    notifyListeners();
  }

  /// The equipment.
  UnmodifiableSetView<String> get equipment => UnmodifiableSetView(_equipment);
  Set<String> _equipment = {};

  /// The selected equipment.
  UnmodifiableSetView<String> get selectedEquipment =>
      UnmodifiableSetView(_selectedEquipment);
  final Set<String> _selectedEquipment = {};

  /// Selects or unselects the [equipment] filter.
  void toggleEquipmentSelectionFor(String equipment) {
    _selectedEquipment.contains(equipment)
        ? _selectedEquipment.remove(equipment)
        : _selectedEquipment.add(equipment);
    notifyListeners();
  }

  /// Unselects all equipment.
  void clearSelectedEquipment() {
    _selectedEquipment.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
