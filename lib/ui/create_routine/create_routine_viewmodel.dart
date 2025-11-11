import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/domain/models/exercise/exercise.dart';

/// A view model for managing the UI state of the Create Routine screen.
class CreateRoutineViewModel extends ChangeNotifier {
  /// Creates a [CreateRoutineViewModel].
  CreateRoutineViewModel();

  /// The exercises added to this view model's screen.
  UnmodifiableListView<Exercise> get addedExercises =>
      UnmodifiableListView(_addedExercises);
  final List<Exercise> _addedExercises = [];

  /// Adds the [exercises] to this view model's screen.
  void addExercises(UnmodifiableSetView<Exercise>? exercises) {
    if (exercises == null) {
      return;
    }
    _addedExercises.addAll(exercises);
    notifyListeners();
  }
}
