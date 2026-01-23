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
    String? routineNotes,
    String? workoutNotes,
    @Default(false) bool shouldSupersetWithNext,
    @Default([]) List<ExerciseSet> sets,
  }) = _RoutineExercise;

  /// The [RoutineExercise] created from [json].
  factory RoutineExercise.fromJson(Map<String, dynamic> json) =>
      _$RoutineExerciseFromJson(json);
}
