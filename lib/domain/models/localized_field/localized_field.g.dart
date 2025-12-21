// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalizedField<T> _$LocalizedFieldFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _LocalizedField<T>(en: fromJsonT(json['en']));

Map<String, dynamic> _$LocalizedFieldToJson<T>(
  _LocalizedField<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{'en': toJsonT(instance.en)};
