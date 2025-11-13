import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leeft/domain/models/exercise/exercise.dart';

part 'routine_exercise.freezed.dart';
part 'routine_exercise.g.dart';

/// An exercise inside a routine.
@freezed
abstract class RoutineExercise with _$RoutineExercise {
  /// Creates a [RoutineExercise].
  const factory RoutineExercise({
    required Exercise exercise,
    @Default(false) bool shouldSupersetWithNext,
  }) = _RoutineExercise;

  /// The [RoutineExercise] created from [json].
  factory RoutineExercise.fromJson(Map<String, dynamic> json) =>
      _$RoutineExerciseFromJson(json);
}
