// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  id: json['id'] as String,
  title: json['title'] as String,
  priority: (json['priority'] as num).toInt(),
  muscleGroup: json['muscleGroup'] as String,
  otherMuscles: (json['otherMuscles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  exerciseType: json['exerciseType'] as String,
  equipment: json['equipment'] as String?,
  mediaUrl: json['mediaUrl'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'priority': instance.priority,
  'muscleGroup': instance.muscleGroup,
  'otherMuscles': instance.otherMuscles,
  'exerciseType': instance.exerciseType,
  'equipment': instance.equipment,
  'mediaUrl': instance.mediaUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'tags': instance.tags,
};
