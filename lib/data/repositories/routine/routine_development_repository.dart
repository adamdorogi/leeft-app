import 'package:relift/data/repositories/routine/routine_repository.dart';
import 'package:relift/data/services/database_service.dart';
import 'package:relift/domain/models/routine/routine.dart';
import 'package:relift/utils/result.dart';

/// A [RoutineRepository] for development.
class RoutineDevelopmentRepository extends RoutineRepository {
  /// Creates a [RoutineDevelopmentRepository] with a [databaseService].
  ///
  /// The [databaseService] manages the routines in the database.
  RoutineDevelopmentRepository({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<Result<int>> saveRoutine(Routine routine) =>
      _databaseService.saveRoutine(routine);

  @override
  Future<Result<void>> deleteRoutine(int routineId) =>
      _databaseService.deleteRoutine(routineId);

  @override
  Future<Result<Routine?>> routine(int routineId) =>
      _databaseService.loadRoutine(routineId);

  @override
  Future<Result<List<Routine>>> get routines => _databaseService.loadRoutines();
}
