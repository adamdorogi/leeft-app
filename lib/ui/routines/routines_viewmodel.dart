import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:leeft/data/repositories/routine/routine_repository.dart';
import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the routines screen.
class RoutinesViewModel extends ChangeNotifier {
  /// Creates a [RoutinesViewModel] with a [routineRepository].
  ///
  /// The [routineRepository] retrieves the saved routines.
  RoutinesViewModel({required RoutineRepository routineRepository})
    : _routineRepository = routineRepository;

  final RoutineRepository _routineRepository;

  final _log = Logger((RoutinesViewModel).toString());

  /// All saved routines.
  UnmodifiableListView<Routine> get routines => UnmodifiableListView(_routines);
  List<Routine> _routines = [];

  /// The command to load the routines from the routine repository.
  late final Command0<void> load = Command0(_load);
  Future<Result<void>> _load() async {
    _log.info('Loading routines...');
    final routinesResult = await _routineRepository.routines;

    switch (routinesResult) {
      case Success(value: final routines):
        _routines = routines;
        _log.info('Successfully loaded ${routines.length} routines.');
        return const Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to load routines: $error');
        return Result.failure(error);
    }
  }

  /// The command to delete a routine from the routine repository.
  late final Command1<void, int> deleteRoutine = Command1(_deleteRoutine);
  Future<Result<void>> _deleteRoutine(int routineId) async {
    _log.info('Deleting routine $routineId...');
    final deleteResult = await _routineRepository.deleteRoutine(routineId);

    switch (deleteResult) {
      case Success():
        _routines.removeWhere((routine) => routine.id == routineId);
        _log.info('Successfully deleted routine $routineId.');
        return const Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to delete routine: $error');
        return Result.failure(error);
    }
  }
}
