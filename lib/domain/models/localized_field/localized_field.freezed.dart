// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localized_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizedField<T> {

 T get en;
/// Create a copy of LocalizedField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedFieldCopyWith<T, LocalizedField<T>> get copyWith => _$LocalizedFieldCopyWithImpl<T, LocalizedField<T>>(this as LocalizedField<T>, _$identity);

  /// Serializes this LocalizedField to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedField<T>&&const DeepCollectionEquality().equals(other.en, en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(en));

@override
String toString() {
  return 'LocalizedField<$T>(en: $en)';
}


}

/// @nodoc
abstract mixin class $LocalizedFieldCopyWith<T,$Res>  {
  factory $LocalizedFieldCopyWith(LocalizedField<T> value, $Res Function(LocalizedField<T>) _then) = _$LocalizedFieldCopyWithImpl;
@useResult
$Res call({
 T en
});




}
/// @nodoc
class _$LocalizedFieldCopyWithImpl<T,$Res>
    implements $LocalizedFieldCopyWith<T, $Res> {
  _$LocalizedFieldCopyWithImpl(this._self, this._then);

  final LocalizedField<T> _self;
  final $Res Function(LocalizedField<T>) _then;

/// Create a copy of LocalizedField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = freezed,}) {
  return _then(_self.copyWith(
en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalizedField].
extension LocalizedFieldPatterns<T> on LocalizedField<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizedField<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizedField() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizedField<T> value)  $default,){
final _that = this;
switch (_that) {
case _LocalizedField():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizedField<T> value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizedField() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizedField() when $default != null:
return $default(_that.en);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T en)  $default,) {final _that = this;
switch (_that) {
case _LocalizedField():
return $default(_that.en);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T en)?  $default,) {final _that = this;
switch (_that) {
case _LocalizedField() when $default != null:
return $default(_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _LocalizedField<T> extends LocalizedField<T> {
  const _LocalizedField({required this.en}): super._();
  factory _LocalizedField.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$LocalizedFieldFromJson(json,fromJsonT);

@override final  T en;

/// Create a copy of LocalizedField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedFieldCopyWith<T, _LocalizedField<T>> get copyWith => __$LocalizedFieldCopyWithImpl<T, _LocalizedField<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$LocalizedFieldToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedField<T>&&const DeepCollectionEquality().equals(other.en, en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(en));

@override
String toString() {
  return 'LocalizedField<$T>(en: $en)';
}


}

/// @nodoc
abstract mixin class _$LocalizedFieldCopyWith<T,$Res> implements $LocalizedFieldCopyWith<T, $Res> {
  factory _$LocalizedFieldCopyWith(_LocalizedField<T> value, $Res Function(_LocalizedField<T>) _then) = __$LocalizedFieldCopyWithImpl;
@override @useResult
$Res call({
 T en
});




}
/// @nodoc
class __$LocalizedFieldCopyWithImpl<T,$Res>
    implements _$LocalizedFieldCopyWith<T, $Res> {
  __$LocalizedFieldCopyWithImpl(this._self, this._then);

  final _LocalizedField<T> _self;
  final $Res Function(_LocalizedField<T>) _then;

/// Create a copy of LocalizedField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = freezed,}) {
  return _then(_LocalizedField<T>(
en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

// dart format on
