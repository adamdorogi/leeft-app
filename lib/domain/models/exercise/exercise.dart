import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

/// An exercise.
@freezed
abstract class Exercise with _$Exercise {
  /// Creates an [Exercise].
  const factory Exercise({
    required String id,
    required String title,
    required int priority,
    required String muscleGroup,
    required List<String> otherMuscles,
    required String exerciseType,
    required String? equipment,
    required String? mediaUrl,
    required String? thumbnailUrl,
    required List<String> tags,
  }) = _Exercise;

  /// The [Exercise] created from [json].
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
