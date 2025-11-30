import 'dart:typed_data';

import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/result.dart';

/// A repository for managing exercise data.
abstract class ExerciseRepository {
  /// The exercises.
  Future<Result<List<Exercise>>> get exercises;

  /// The thumbnail for the exercise with the [exerciseId].
  Future<Result<Uint8List>> thumbnailFor(String exerciseId);
}
