import 'package:isar/isar.dart';

import 'package:leeft/domain/models/routine/routine.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

/// A stateless service for interacting with the Isar database.
class DatabaseService {
  final _log = Logger((DatabaseService).toString());

  Future<Isar> get _isar async {
    final directory = await getApplicationDocumentsDirectory();
    return Isar.getInstance() ??
        await Isar.open([RoutineSchema], directory: directory.path);
  }

  /// Adds a [routine] to the database.
  Future<Result<int>> insertRoutine(Routine routine) async {
    _log.info('Adding routine to Isar database...');
    try {
      final isar = await _isar;
      final id = await isar.writeTxn(() => isar.routines.put(routine));
      return Result.success(id);
    } on Exception catch (e) {
      _log.warning('Failed to insert routine: $e');
      return Result.failure(e);
    }
  }

  /// Retrieves all routines from the database.
  Future<Result<List<Routine>>> loadRoutines() async {
    _log.info('Loading routines from Isar database...');
    try {
      final isar = await _isar;
      final routines = await isar.routines.where().findAll();
      return Result.success(routines);
    } on Exception catch (e) {
      _log.warning('Failed to load routines: $e');
      return Result.failure(e);
    }
  }

  /// Deletes the routine with [routineId] from the database.
  Future<Result<void>> deleteRoutine(int routineId) async {
    _log.info('Deleting routine from Isar database...');
    try {
      final isar = await _isar;
      await isar.writeTxn(() => isar.routines.delete(routineId));
      return const Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to delete routine $routineId: $e');
      return Result.failure(e);
    }
  }
}
