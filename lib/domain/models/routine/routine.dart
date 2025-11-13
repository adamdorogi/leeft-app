import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leeft/domain/models/routine_exercise/routine_exercise.dart';

part 'routine.freezed.dart';
part 'routine.g.dart';

/// A routine.
@freezed
abstract class Routine with _$Routine {
  /// Creates a [Routine].
  const factory Routine({
    required String id,
    required String name,
    @Default([]) List<RoutineExercise> routineExercises,
  }) = _Routine;

  /// The [Routine] created from [json].
  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);
}
