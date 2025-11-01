import 'dart:collection';

import 'package:flutter/foundation.dart';

class CreateRoutineViewModel extends ChangeNotifier {
  CreateRoutineViewModel();

  final List<String> _addedExerciseIds = [];

  UnmodifiableListView<String> get addedExerciseIds =>
      UnmodifiableListView(_addedExerciseIds);

  void addExerciseIds(UnmodifiableSetView<String>? exerciseIds) {
    if (exerciseIds == null) {
      return;
    }
    _addedExerciseIds.addAll(exerciseIds);
    notifyListeners();
  }
}
