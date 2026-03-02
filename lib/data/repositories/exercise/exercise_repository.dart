import 'package:relift/domain/models/exercise/exercise.dart';
import 'package:relift/utils/result.dart';

/// A repository for managing exercise data.
abstract class ExerciseRepository {
  /// The exercises.
  Future<Result<List<Exercise>>> get exercises;

  /// The exercise with the [exerciseId].
  Future<Result<Exercise>> exerciseWith(String exerciseId);
}
