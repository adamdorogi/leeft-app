// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => _ExerciseSet(
  rest: (json['rest'] as num).toInt(),
  isWarmUp: json['isWarmUp'] as bool? ?? false,
  reps: (json['reps'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ExerciseSetToJson(_ExerciseSet instance) =>
    <String, dynamic>{
      'rest': instance.rest,
      'isWarmUp': instance.isWarmUp,
      'reps': instance.reps,
      'weight': instance.weight,
    };
