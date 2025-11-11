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
    : _localDataService = localDataService;

  final LocalDataService _localDataService;

  @override
  AsyncResult<List<Exercise>> get exercises => _localDataService.exercises;
}
