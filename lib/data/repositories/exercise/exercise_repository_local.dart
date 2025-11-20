import 'package:result_dart/result_dart.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';

/// A repository for managing exercise data locally.
class ExerciseRepositoryLocal extends ExerciseRepository {
  /// Creates an [ExerciseRepositoryLocal].
  ///
  /// The [localDataService] is used to retrieve assets from the asset bundle.
  ExerciseRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService {
    // Prefetch exercises, fire-and-forget.
    // ignore: discarded_futures
    exercises;
  }

  final LocalDataService _localDataService;

  // Keep track of cached and inflight exercises, so we can prevent duplicate
  // requests when invoked by multiple view models concurrently.
  List<Exercise>? _cachedExercises;
  AsyncResult<List<Exercise>>? _inflightExercises;

  @override
  AsyncResult<List<Exercise>> get exercises async {
    // If we have cached exercises, return those.
    if (_cachedExercises != null) {
      return Success(_cachedExercises!);
    }

    // If exercises are already being fetched, return their future.
    // This prevents duplicate requests.
    if (_inflightExercises != null) {
      return _inflightExercises!;
    }

    // First time fetching exercises, store their future.
    _inflightExercises = _localDataService.exercises;
    final exercisesResult = await _inflightExercises!;

    // Cache the exercises if successful, and clear the inflight exercises.
    _cachedExercises = exercisesResult.getOrNull();
    _inflightExercises = null;

    return exercisesResult;
  }
}
