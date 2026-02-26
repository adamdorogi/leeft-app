// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localized_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocalizedField<T> _$LocalizedFieldFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _LocalizedField<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$LocalizedField<T> {
  T get en => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalizedFieldCopyWith<T, LocalizedField<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizedFieldCopyWith<T, $Res> {
  factory $LocalizedFieldCopyWith(
          LocalizedField<T> value, $Res Function(LocalizedField<T>) then) =
      _$LocalizedFieldCopyWithImpl<T, $Res, LocalizedField<T>>;
  @useResult
  $Res call({T en});
}

/// @nodoc
class _$LocalizedFieldCopyWithImpl<T, $Res, $Val extends LocalizedField<T>>
    implements $LocalizedFieldCopyWith<T, $Res> {
  _$LocalizedFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? en = freezed,
  }) {
    return _then(_value.copyWith(
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalizedFieldImplCopyWith<T, $Res>
    implements $LocalizedFieldCopyWith<T, $Res> {
  factory _$$LocalizedFieldImplCopyWith(_$LocalizedFieldImpl<T> value,
          $Res Function(_$LocalizedFieldImpl<T>) then) =
      __$$LocalizedFieldImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T en});
}

/// @nodoc
class __$$LocalizedFieldImplCopyWithImpl<T, $Res>
    extends _$LocalizedFieldCopyWithImpl<T, $Res, _$LocalizedFieldImpl<T>>
    implements _$$LocalizedFieldImplCopyWith<T, $Res> {
  __$$LocalizedFieldImplCopyWithImpl(_$LocalizedFieldImpl<T> _value,
      $Res Function(_$LocalizedFieldImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? en = freezed,
  }) {
    return _then(_$LocalizedFieldImpl<T>(
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$LocalizedFieldImpl<T> extends _LocalizedField<T> {
  const _$LocalizedFieldImpl({required this.en}) : super._();

  factory _$LocalizedFieldImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$LocalizedFieldImplFromJson(json, fromJsonT);

  @override
  final T en;

  @override
  String toString() {
    return 'LocalizedField<$T>(en: $en)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizedFieldImpl<T> &&
            const DeepCollectionEquality().equals(other.en, en));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(en));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizedFieldImplCopyWith<T, _$LocalizedFieldImpl<T>> get copyWith =>
      __$$LocalizedFieldImplCopyWithImpl<T, _$LocalizedFieldImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$LocalizedFieldImplToJson<T>(this, toJsonT);
  }
}

abstract class _LocalizedField<T> extends LocalizedField<T> {
  const factory _LocalizedField({required final T en}) =
      _$LocalizedFieldImpl<T>;
  const _LocalizedField._() : super._();

  factory _LocalizedField.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$LocalizedFieldImpl<T>.fromJson;

  @override
  T get en;
  @override
  @JsonKey(ignore: true)
  _$$LocalizedFieldImplCopyWith<T, _$LocalizedFieldImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
