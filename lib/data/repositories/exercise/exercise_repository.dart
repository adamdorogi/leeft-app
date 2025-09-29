import 'package:result_dart/result_dart.dart';

import 'package:leeft/domain/models/exercise/exercise.dart';

abstract class ExerciseRepository {
  AsyncResult<List<Exercise>> get exercises;
}
