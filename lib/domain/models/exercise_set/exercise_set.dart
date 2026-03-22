import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'exercise_set.freezed.dart';
part 'exercise_set.g.dart';

/// An exercise set.
@freezed
// Ignore ID for database storage, as it's only used for state management.
@Embedded(ignore: {'copyWith', 'id'})
class ExerciseSet with _$ExerciseSet {
  /// Creates an [ExerciseSet].
  const factory ExerciseSet({
    String? id,
    @Default(false) bool isWarmUp,
    int? reps,
    double? weight,
    int? rest,
    double? duration,
    double? distance,
  }) = _ExerciseSet;

  /// The [ExerciseSet] created from [json].
  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
}
