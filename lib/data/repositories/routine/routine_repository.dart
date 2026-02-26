import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/utils/result.dart';

/// A repository for managing routine data.
abstract class RoutineRepository {
  /// Saves the [routine].
  Future<Result<int>> saveRoutine(Routine routine);

  /// Deletes the routine with [routineId].
  Future<Result<void>> deleteRoutine(int routineId);

  /// All saved routines.
  Future<Result<List<Routine>>> get routines;
}
