import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leeft/domain/models/exercise_set/exercise_set.dart';

part 'routine_exercise.freezed.dart';
part 'routine_exercise.g.dart';

/// An exercise inside a routine.
@freezed
abstract class RoutineExercise with _$RoutineExercise {
  /// Creates a [RoutineExercise].
  const factory RoutineExercise({
    required String exerciseId,
    required List<ExerciseSet> sets,
    String? routineNotes,
    String? workoutNotes,
    @Default(false) bool shouldSupersetWithNext,
  }) = _RoutineExercise;

  /// The [RoutineExercise] created from [json].
  factory RoutineExercise.fromJson(Map<String, dynamic> json) =>
      _$RoutineExerciseFromJson(json);
}
