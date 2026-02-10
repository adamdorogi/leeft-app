// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineExercise _$RoutineExerciseFromJson(Map<String, dynamic> json) =>
    _RoutineExercise(
      exerciseId: json['exerciseId'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      routineNotes: json['routineNotes'] as String?,
      workoutNotes: json['workoutNotes'] as String?,
      shouldSupersetWithNext: json['shouldSupersetWithNext'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutineExerciseToJson(_RoutineExercise instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'sets': instance.sets,
      'routineNotes': instance.routineNotes,
      'workoutNotes': instance.workoutNotes,
      'shouldSupersetWithNext': instance.shouldSupersetWithNext,
    };
