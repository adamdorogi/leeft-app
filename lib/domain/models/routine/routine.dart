import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import 'package:leeft/domain/models/exercise_set/exercise_set.dart';
import 'package:leeft/domain/models/routine_exercise/routine_exercise.dart';

part 'routine.freezed.dart';
part 'routine.g.dart';

/// A routine.
@freezed
@Collection(ignore: {'copyWith'})
class Routine with _$Routine {
  /// Creates a [Routine].
  const factory Routine({
    String? name,
    @Default(Isar.autoIncrement) Id id,
    @Default([]) List<RoutineExercise> routineExercises,
  }) = _Routine;
  const Routine._();

  /// The [Routine] created from [json].
  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  @override
  Id get id => Isar.autoIncrement;
}
