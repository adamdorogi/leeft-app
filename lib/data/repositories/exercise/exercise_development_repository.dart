import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/asset_bundle_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/memoizer.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// An [ExerciseRepository] for development.
class ExerciseDevelopmentRepository extends ExerciseRepository {
  /// Creates a [ExerciseDevelopmentRepository] with an [assetBundleService].
  ///
  /// The [assetBundleService] loads the exercises from the asset bundle.
  ExerciseDevelopmentRepository({
    required AssetBundleService assetBundleService,
  }) : _assetBundleService = assetBundleService;

  final _log = Logger((ExerciseDevelopmentRepository).toString());

  final AssetBundleService _assetBundleService;

  @override
  Future<Result<List<Exercise>>> get exercises async {
    _log.info('Retrieving exercises...');
    final exercisesMapResult = await _exercisesMemoizer.run();

    switch (exercisesMapResult) {
      case Success(value: final exercisesMap):
        _log.info('Successfully retrieved ${exercisesMap.length} exercises.');
        return Result.success(exercisesMap.values.toList());
      case Failure(:final error):
        _log.warning('Failed to retrieve exercises: $error');
        return Result.failure(error);
    }
  }

  late final Memoizer0<Map<String, Exercise>> _exercisesMemoizer = Memoizer0(
    _loadExercises,
  );

  Future<Result<Map<String, Exercise>>> _loadExercises() async {
    final exercisesResult = await _assetBundleService.loadExercises();

    switch (exercisesResult) {
      case Success(value: final exercises):
        return Result.success({
          for (final exercise in exercises) exercise.id: exercise,
        });
      case Failure(:final error):
        return Result.failure(error);
    }
  }

  @override
  Future<Result<Exercise>> exerciseWith(String exerciseId) async {
    _log.info('Retrieving exercise $exerciseId...');
    final exercisesMapResult = await _exercisesMemoizer.run();

    switch (exercisesMapResult) {
      case Success(value: final exercisesMap):
        final exercise = exercisesMap[exerciseId];
        if (exercise == null) {
          _log.warning(
            'Failed to retrieve exercise $exerciseId: No exercise with ID '
            '$exerciseId.',
          );
          return Result.failure(
            FormatException('No exercise with ID $exerciseId.'),
          );
        }
        _log.info('Successfully retrieved exercise $exerciseId.');
        return Result.success(exercise);
      case Failure(:final error):
        _log.warning('Failed to retrieve exercise $exerciseId: $error');
        return Result.failure(error);
    }
  }
}
