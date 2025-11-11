import 'dart:collection';

import 'package:flutter/foundation.dart';

/// A view model for managing the UI state of the Create Routine screen.
class CreateRoutineViewModel extends ChangeNotifier {
  /// Creates a [CreateRoutineViewModel].
  CreateRoutineViewModel();

  /// The exercises added to this view model's screen.
  UnmodifiableListView<String> get addedExerciseIds =>
      UnmodifiableListView(_addedExerciseIds);
  final List<String> _addedExerciseIds = [];

  /// Add the exercises with the given [exerciseIds] to this view model's
  /// screen.
  void addExerciseIds(UnmodifiableSetView<String>? exerciseIds) {
    if (exerciseIds == null) {
      return;
    }
    _addedExerciseIds.addAll(exerciseIds);
    notifyListeners();
  }
}
