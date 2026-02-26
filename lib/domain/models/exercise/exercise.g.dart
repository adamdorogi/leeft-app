// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: json['id'] as String,
      title: LocalizedField<String>.fromJson(
          json['title'] as Map<String, dynamic>, (value) => value as String),
      priority: (json['priority'] as num).toInt(),
      muscleGroup: json['muscleGroup'] as String,
      otherMuscles: (json['otherMuscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      exerciseType: json['exerciseType'] as String,
      equipment: json['equipment'] as String,
      mediaUrl: json['mediaUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      instructions: LocalizedField<List<String>>.fromJson(
          json['instructions'] as Map<String, dynamic>,
          (value) => (value as List<dynamic>).map((e) => e as String).toList()),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(
        (value) => value,
      ),
      'priority': instance.priority,
      'muscleGroup': instance.muscleGroup,
      'otherMuscles': instance.otherMuscles,
      'exerciseType': instance.exerciseType,
      'equipment': instance.equipment,
      'mediaUrl': instance.mediaUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'instructions': instance.instructions.toJson(
        (value) => value,
      ),
      'tags': instance.tags,
    };
