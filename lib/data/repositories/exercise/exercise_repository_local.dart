import 'dart:typed_data';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/data/services/remote_data_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/memoized_result.dart';
import 'package:leeft/utils/result.dart';

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
  Future<Result<List<Exercise>>> get exercises => _memoizedExercises.invoke();

  Future<Result<List<Exercise>>> _getExercises() => _localDataService.exercises;

  @override
  Future<Result<Uint8List>> thumbnailFor(String exerciseId) =>
      _memoizedThumbnails.invoke(exerciseId);

  Future<Result<Uint8List>> _thumbnailFor(String exerciseId) async {
    final exerciseResult = await _exerciseWith(exerciseId);
    switch (exerciseResult) {
      case Success():
        final exercise = exerciseResult.value;
        if (exercise.thumbnailUrl != null) {
          return _remoteDataService.bytesAt(exercise.thumbnailUrl!);
        }
        return Result.failure(Exception('Exercise has no thumbnail.'));
      case Failure():
        return Result.failure(exerciseResult.error);
    }
  }

  Future<Result<Exercise>> _exerciseWith(String exerciseId) async {
    final exercisesResult = await exercises;
    switch (exercisesResult) {
      case Success():
        for (final exercise in exercisesResult.value) {
          if (exercise.id == exerciseId) {
            return Result.success(exercise);
          }
        }
        return Result.failure(
          Exception('Cannot find exercise with ID $exerciseId.'),
        );
      case Failure():
        return Result.failure(exercisesResult.error);
    }
  }
}
