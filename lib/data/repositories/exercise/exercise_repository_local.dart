import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/data/services/remote_data_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/memoized_result.dart';

/// A repository for managing exercise data locally.
class ExerciseRepositoryLocal extends ExerciseRepository {
  /// Creates an [ExerciseRepositoryLocal].
  ///
  /// The [localDataService] is used to retrieve assets from the asset bundle.
  ExerciseRepositoryLocal({
    required LocalDataService localDataService,
    required RemoteDataService remoteDataService,
  }) : _localDataService = localDataService,
       _remoteDataService = remoteDataService {
    _memoizedExercises = MemoizedResult0(_getExercises);
    _memoizedThumbnails = MemoizedResult1(_thumbnailFor);
  }

  final LocalDataService _localDataService;
  final RemoteDataService _remoteDataService;

  late MemoizedResult0<List<Exercise>> _memoizedExercises;
  late MemoizedResult1<Uint8List, String> _memoizedThumbnails;

  @override
  AsyncResult<List<Exercise>> get exercises => _memoizedExercises.invoke();

  AsyncResult<List<Exercise>> _getExercises() => _localDataService.exercises;

  @override
  AsyncResult<Uint8List> thumbnailFor(String exerciseId) =>
      _memoizedThumbnails.invoke(exerciseId);

  AsyncResult<Uint8List> _thumbnailFor(String exerciseId) async {
    final exerciseResult = await _exerciseWith(exerciseId);
    if (exerciseResult.isSuccess()) {
      final exercise = exerciseResult.getOrNull()!;
      if (exercise.thumbnailUrl != null) {
        return _remoteDataService.bytesAt(exercise.thumbnailUrl!);
      }
    }

    return Failure(Exception('Failed to get exercise thumbnail.'));
  }

  AsyncResult<Exercise> _exerciseWith(String exerciseId) async {
    final exercisesResult = await exercises;
    if (exercisesResult.isSuccess()) {
      for (final exercise in exercisesResult.getOrNull()!) {
        if (exercise.id == exerciseId) {
          return Success(exercise);
        }
      }
    }
    return Failure(Exception('Cannot find exercise with ID $exerciseId.'));
  }
}
