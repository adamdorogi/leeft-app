import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import 'package:leeft/domain/models/exercise_set/exercise_set.dart';

part 'routine_exercise.freezed.dart';
part 'routine_exercise.g.dart';

/// An exercise inside a routine.
@freezed
@Embedded(ignore: {'copyWith'})
class RoutineExercise with _$RoutineExercise {
  /// Creates a [RoutineExercise].
  const factory RoutineExercise({
    String? exerciseId,
    @Default([]) List<ExerciseSet> sets,
    String? notes,
    @Default(false) bool shouldSupersetWithNext,
  }) = _RoutineExercise;

  /// The [RoutineExercise] created from [json].
  factory RoutineExercise.fromJson(Map<String, dynamic> json) =>
      _$RoutineExerciseFromJson(json);
}
