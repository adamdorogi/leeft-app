import 'package:result_dart/result_dart.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';

class ExerciseRepositoryLocal extends ExerciseRepository {
  ExerciseRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  final LocalDataService _localDataService;

  @override
  AsyncResult<List<Exercise>> get exercises {
    return _localDataService.exercises;
  }
}
