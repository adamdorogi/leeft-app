// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  id: json['id'] as String,
  name: json['name'] as String,
  bodyPart: json['bodyPart'] as String,
  target: json['target'] as String,
  equipment: json['equipment'] as String,
  secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  instructions: (json['instructions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'bodyPart': instance.bodyPart,
  'target': instance.target,
  'equipment': instance.equipment,
  'secondaryMuscles': instance.secondaryMuscles,
  'instructions': instance.instructions,
};
