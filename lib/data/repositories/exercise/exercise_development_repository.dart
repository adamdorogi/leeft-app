import 'dart:typed_data';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/asset_bundle_service.dart';
import 'package:leeft/data/services/remote_data_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/memoizer.dart';
import 'package:leeft/utils/result.dart';

/// An [ExerciseRepository] for development.
class ExerciseDevelopmentRepository extends ExerciseRepository {
  /// Creates a [ExerciseDevelopmentRepository] with an [assetBundleService] and
  /// [remoteDataService].
  ///
  /// The [assetBundleService] loads the exercises from the exercises asset.
  ///
  /// The [remoteDataService] downloads the exercise thumbnail bytes from the
  /// exercise thumbnail URLs.
  ExerciseDevelopmentRepository({
    required AssetBundleService assetBundleService,
    required RemoteDataService remoteDataService,
  }) : _assetBundleService = assetBundleService,
       _remoteDataService = remoteDataService;

  final AssetBundleService _assetBundleService;
  final RemoteDataService _remoteDataService;

  @override
  Future<Result<List<Exercise>>> get exercises async {
    final exercisesMapResult = await _exercisesMemoizer.run();

    switch (exercisesMapResult) {
      case Success(value: final exercisesMap):
        return Result.success(exercisesMap.values.toList());
      case Failure(:final error):
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
    final exercisesMapResult = await _exercisesMemoizer.run();

    switch (exercisesMapResult) {
      case Success(value: final exercisesMap):
        final exercise = exercisesMap[exerciseId];
        if (exercise == null) {
          return Result.failure(
            FormatException('No exercise found with ID $exercise.'),
          );
        }
        return Result.success(exercise);
      case Failure(:final error):
        return Result.failure(error);
    }
  }

  @override
  Future<Result<Uint8List>> thumbnailBytesFor(String exerciseId) =>
      _thumbnailBytesMemoizer.run(exerciseId);

  late final Memoizer1<Uint8List, String> _thumbnailBytesMemoizer = Memoizer1(
    _downloadThumbnailBytesFor,
  );

  Future<Result<Uint8List>> _downloadThumbnailBytesFor(
    String exerciseId,
  ) async {
    final exerciseResult = await exerciseWith(exerciseId);

    switch (exerciseResult) {
      case Success(value: final exercise):
        final thumbnailUrl = exercise.thumbnailUrl;
        if (thumbnailUrl == null) {
          return Result.failure(
            FormatException('No thumbnail for exercise with ID $exercise.'),
          );
        }
        return _remoteDataService.downloadBytesFrom(thumbnailUrl);
      case Failure(:final error):
        return Result.failure(error);
    }
  }
}
