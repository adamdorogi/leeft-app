// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalizedFieldImpl<T> _$$LocalizedFieldImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$LocalizedFieldImpl<T>(
      en: fromJsonT(json['en']),
    );

Map<String, dynamic> _$$LocalizedFieldImplToJson<T>(
  _$LocalizedFieldImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'en': toJsonT(instance.en),
    };
