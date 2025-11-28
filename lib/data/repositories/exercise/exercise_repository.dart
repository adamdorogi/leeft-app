import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';

import 'package:leeft/domain/models/exercise/exercise.dart';

/// A repository for managing exercise data.
abstract class ExerciseRepository {
  /// The exercises.
  AsyncResult<List<Exercise>> get exercises;

  /// The thumbnail for the exercise with the [exerciseId].
  AsyncResult<Uint8List> thumbnailFor(String exerciseId);
}
