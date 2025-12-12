import 'dart:typed_data';

import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/result.dart';

/// A repository for managing exercise data.
abstract class ExerciseRepository {
  /// The exercises.
  Future<Result<List<Exercise>>> get exercises;

  /// The exercise with the [exerciseId].
  Future<Result<Exercise>> exerciseWith(String exerciseId);

  /// The thumbnail bytes for the exercise with the [exerciseId].
  Future<Result<Uint8List>> thumbnailBytesFor(String exerciseId);
}
