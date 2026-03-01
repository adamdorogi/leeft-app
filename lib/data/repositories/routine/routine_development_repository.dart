import 'package:leeft/data/repositories/routine/routine_repository.dart';
import 'package:leeft/data/services/database_service.dart';
import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A [RoutineRepository] for development.
class RoutineDevelopmentRepository extends RoutineRepository {
  /// Creates a [RoutineDevelopmentRepository] with a [databaseService].
  ///
  /// The [databaseService] manages the routines in the database.
  RoutineDevelopmentRepository({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final _log = Logger((RoutineDevelopmentRepository).toString());

  final DatabaseService _databaseService;

  @override
  Future<Result<int>> saveRoutine(Routine routine) async {
    _log.info('Saving routine...');
    final result = await _databaseService.insertRoutine(routine);

    switch (result) {
      case Success(value: final routineId):
        _log.info('Successfully saved routine $routineId.');
        return Result.success(routineId);
      case Failure(:final error):
        _log.warning('Failed to save routine: $error');
        return Result.failure(error);
    }
  }

  @override
  Future<Result<void>> deleteRoutine(int routineId) async {
    _log.info('Deleting routine...');
    final result = await _databaseService.deleteRoutine(routineId);

    switch (result) {
      case Success():
        _log.info('Successfully deleted routine $routineId.');
        return Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to delete routine: $error');
        return Result.failure(error);
    }
  }

  @override
  Future<Result<List<Routine>>> get routines async {
    _log.info('Loading routines...');
    final result = await _databaseService.loadRoutines();

    switch (result) {
      case Success(value: final routines):
        _log.info('Successfully loaded ${routines.length} routines.');
        return Result.success(routines);
      case Failure(:final error):
        _log.warning('Failed to load routines: $error');
        return Result.failure(error);
    }
  }
}
