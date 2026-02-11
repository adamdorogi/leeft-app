import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set.freezed.dart';
part 'exercise_set.g.dart';

/// An exercise set.
@freezed
abstract class ExerciseSet with _$ExerciseSet {
  /// Creates an [ExerciseSet].
  const factory ExerciseSet({
    required int rest,
    @Default(false) bool isWarmUp,
    int? reps,
    double? weight,
    double? duration,
    double? distance,
  }) = _ExerciseSet;

  /// The [ExerciseSet] created from [json].
  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
}
