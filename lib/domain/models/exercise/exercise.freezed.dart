// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exercise {

 String get id; String get title; int get priority; String get muscleGroup; List<String> get otherMuscles; String get exerciseType; String? get equipment; String? get mediaUrl; String? get thumbnailUrl; List<String> get tags;
/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCopyWith<Exercise> get copyWith => _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&const DeepCollectionEquality().equals(other.otherMuscles, otherMuscles)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priority,muscleGroup,const DeepCollectionEquality().hash(otherMuscles),exerciseType,equipment,mediaUrl,thumbnailUrl,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'Exercise(id: $id, title: $title, priority: $priority, muscleGroup: $muscleGroup, otherMuscles: $otherMuscles, exerciseType: $exerciseType, equipment: $equipment, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res>  {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) = _$ExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String title, int priority, String muscleGroup, List<String> otherMuscles, String exerciseType, String? equipment, String? mediaUrl, String? thumbnailUrl, List<String> tags
});




}
/// @nodoc
class _$ExerciseCopyWithImpl<$Res>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? muscleGroup = null,Object? otherMuscles = null,Object? exerciseType = null,Object? equipment = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,otherMuscles: null == otherMuscles ? _self.otherMuscles : otherMuscles // ignore: cast_nullable_to_non_nullable
as List<String>,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as String,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exercise value)  $default,){
final _that = this;
switch (_that) {
case _Exercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exercise value)?  $default,){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int priority,  String muscleGroup,  List<String> otherMuscles,  String exerciseType,  String? equipment,  String? mediaUrl,  String? thumbnailUrl,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.muscleGroup,_that.otherMuscles,_that.exerciseType,_that.equipment,_that.mediaUrl,_that.thumbnailUrl,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int priority,  String muscleGroup,  List<String> otherMuscles,  String exerciseType,  String? equipment,  String? mediaUrl,  String? thumbnailUrl,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _Exercise():
return $default(_that.id,_that.title,_that.priority,_that.muscleGroup,_that.otherMuscles,_that.exerciseType,_that.equipment,_that.mediaUrl,_that.thumbnailUrl,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int priority,  String muscleGroup,  List<String> otherMuscles,  String exerciseType,  String? equipment,  String? mediaUrl,  String? thumbnailUrl,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.muscleGroup,_that.otherMuscles,_that.exerciseType,_that.equipment,_that.mediaUrl,_that.thumbnailUrl,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Exercise implements Exercise {
  const _Exercise({required this.id, required this.title, required this.priority, required this.muscleGroup, required final  List<String> otherMuscles, required this.exerciseType, required this.equipment, required this.mediaUrl, required this.thumbnailUrl, required final  List<String> tags}): _otherMuscles = otherMuscles,_tags = tags;
  factory _Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

@override final  String id;
@override final  String title;
@override final  int priority;
@override final  String muscleGroup;
 final  List<String> _otherMuscles;
@override List<String> get otherMuscles {
  if (_otherMuscles is EqualUnmodifiableListView) return _otherMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_otherMuscles);
}

@override final  String exerciseType;
@override final  String? equipment;
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCopyWith<_Exercise> get copyWith => __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&const DeepCollectionEquality().equals(other._otherMuscles, _otherMuscles)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priority,muscleGroup,const DeepCollectionEquality().hash(_otherMuscles),exerciseType,equipment,mediaUrl,thumbnailUrl,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'Exercise(id: $id, title: $title, priority: $priority, muscleGroup: $muscleGroup, otherMuscles: $otherMuscles, exerciseType: $exerciseType, equipment: $equipment, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) = __$ExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int priority, String muscleGroup, List<String> otherMuscles, String exerciseType, String? equipment, String? mediaUrl, String? thumbnailUrl, List<String> tags
});




}
/// @nodoc
class __$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? muscleGroup = null,Object? otherMuscles = null,Object? exerciseType = null,Object? equipment = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? tags = null,}) {
  return _then(_Exercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,otherMuscles: null == otherMuscles ? _self._otherMuscles : otherMuscles // ignore: cast_nullable_to_non_nullable
as List<String>,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as String,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
