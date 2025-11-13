// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineExercise _$RoutineExerciseFromJson(Map<String, dynamic> json) =>
    _RoutineExercise(
      exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      shouldSupersetWithNext: json['shouldSupersetWithNext'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutineExerciseToJson(_RoutineExercise instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'shouldSupersetWithNext': instance.shouldSupersetWithNext,
    };
