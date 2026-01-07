import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leeft/domain/models/localized_field/localized_field.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

/// An exercise.
@freezed
abstract class Exercise with _$Exercise {
  /// Creates an [Exercise].
  const factory Exercise({
    required String id,
    required LocalizedField<String> title,
    required int priority,
    required String muscleGroup,
    required List<String> otherMuscles,
    required String exerciseType,
    required String equipment,
    required String? mediaUrl,
    required String? thumbnailUrl,
    required LocalizedField<List<String>> instructions,
    required List<String> tags,
  }) = _Exercise;

  /// The [Exercise] created from [json].
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
