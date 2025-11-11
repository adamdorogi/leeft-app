import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

/// An exercise.
@freezed
abstract class Exercise with _$Exercise {
  /// Creates an [Exercise].
  const factory Exercise({
    required String id,
    required String name,
    required String bodyPart,
    required String target,
    required String equipment,
    required List<String> secondaryMuscles,
    required List<String> instructions,
  }) = _Exercise;

  /// The [Exercise] created from [json].
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
