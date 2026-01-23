// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoutineExercise {

 String get exerciseId; String? get routineNotes; String? get workoutNotes; bool get shouldSupersetWithNext; List<ExerciseSet> get sets;
/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineExerciseCopyWith<RoutineExercise> get copyWith => _$RoutineExerciseCopyWithImpl<RoutineExercise>(this as RoutineExercise, _$identity);

  /// Serializes this RoutineExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineExercise&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.routineNotes, routineNotes) || other.routineNotes == routineNotes)&&(identical(other.workoutNotes, workoutNotes) || other.workoutNotes == workoutNotes)&&(identical(other.shouldSupersetWithNext, shouldSupersetWithNext) || other.shouldSupersetWithNext == shouldSupersetWithNext)&&const DeepCollectionEquality().equals(other.sets, sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,routineNotes,workoutNotes,shouldSupersetWithNext,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'RoutineExercise(exerciseId: $exerciseId, routineNotes: $routineNotes, workoutNotes: $workoutNotes, shouldSupersetWithNext: $shouldSupersetWithNext, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $RoutineExerciseCopyWith<$Res>  {
  factory $RoutineExerciseCopyWith(RoutineExercise value, $Res Function(RoutineExercise) _then) = _$RoutineExerciseCopyWithImpl;
@useResult
$Res call({
 String exerciseId, String? routineNotes, String? workoutNotes, bool shouldSupersetWithNext, List<ExerciseSet> sets
});




}
/// @nodoc
class _$RoutineExerciseCopyWithImpl<$Res>
    implements $RoutineExerciseCopyWith<$Res> {
  _$RoutineExerciseCopyWithImpl(this._self, this._then);

  final RoutineExercise _self;
  final $Res Function(RoutineExercise) _then;

/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? routineNotes = freezed,Object? workoutNotes = freezed,Object? shouldSupersetWithNext = null,Object? sets = null,}) {
  return _then(_self.copyWith(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,routineNotes: freezed == routineNotes ? _self.routineNotes : routineNotes // ignore: cast_nullable_to_non_nullable
as String?,workoutNotes: freezed == workoutNotes ? _self.workoutNotes : workoutNotes // ignore: cast_nullable_to_non_nullable
as String?,shouldSupersetWithNext: null == shouldSupersetWithNext ? _self.shouldSupersetWithNext : shouldSupersetWithNext // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineExercise].
extension RoutineExercisePatterns on RoutineExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineExercise value)  $default,){
final _that = this;
switch (_that) {
case _RoutineExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineExercise value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseId,  String? routineNotes,  String? workoutNotes,  bool shouldSupersetWithNext,  List<ExerciseSet> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
return $default(_that.exerciseId,_that.routineNotes,_that.workoutNotes,_that.shouldSupersetWithNext,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseId,  String? routineNotes,  String? workoutNotes,  bool shouldSupersetWithNext,  List<ExerciseSet> sets)  $default,) {final _that = this;
switch (_that) {
case _RoutineExercise():
return $default(_that.exerciseId,_that.routineNotes,_that.workoutNotes,_that.shouldSupersetWithNext,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseId,  String? routineNotes,  String? workoutNotes,  bool shouldSupersetWithNext,  List<ExerciseSet> sets)?  $default,) {final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
return $default(_that.exerciseId,_that.routineNotes,_that.workoutNotes,_that.shouldSupersetWithNext,_that.sets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineExercise implements RoutineExercise {
  const _RoutineExercise({required this.exerciseId, this.routineNotes, this.workoutNotes, this.shouldSupersetWithNext = false, final  List<ExerciseSet> sets = const []}): _sets = sets;
  factory _RoutineExercise.fromJson(Map<String, dynamic> json) => _$RoutineExerciseFromJson(json);

@override final  String exerciseId;
@override final  String? routineNotes;
@override final  String? workoutNotes;
@override@JsonKey() final  bool shouldSupersetWithNext;
 final  List<ExerciseSet> _sets;
@override@JsonKey() List<ExerciseSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineExerciseCopyWith<_RoutineExercise> get copyWith => __$RoutineExerciseCopyWithImpl<_RoutineExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineExercise&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.routineNotes, routineNotes) || other.routineNotes == routineNotes)&&(identical(other.workoutNotes, workoutNotes) || other.workoutNotes == workoutNotes)&&(identical(other.shouldSupersetWithNext, shouldSupersetWithNext) || other.shouldSupersetWithNext == shouldSupersetWithNext)&&const DeepCollectionEquality().equals(other._sets, _sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,routineNotes,workoutNotes,shouldSupersetWithNext,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'RoutineExercise(exerciseId: $exerciseId, routineNotes: $routineNotes, workoutNotes: $workoutNotes, shouldSupersetWithNext: $shouldSupersetWithNext, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$RoutineExerciseCopyWith<$Res> implements $RoutineExerciseCopyWith<$Res> {
  factory _$RoutineExerciseCopyWith(_RoutineExercise value, $Res Function(_RoutineExercise) _then) = __$RoutineExerciseCopyWithImpl;
@override @useResult
$Res call({
 String exerciseId, String? routineNotes, String? workoutNotes, bool shouldSupersetWithNext, List<ExerciseSet> sets
});




}
/// @nodoc
class __$RoutineExerciseCopyWithImpl<$Res>
    implements _$RoutineExerciseCopyWith<$Res> {
  __$RoutineExerciseCopyWithImpl(this._self, this._then);

  final _RoutineExercise _self;
  final $Res Function(_RoutineExercise) _then;

/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? routineNotes = freezed,Object? workoutNotes = freezed,Object? shouldSupersetWithNext = null,Object? sets = null,}) {
  return _then(_RoutineExercise(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,routineNotes: freezed == routineNotes ? _self.routineNotes : routineNotes // ignore: cast_nullable_to_non_nullable
as String?,workoutNotes: freezed == workoutNotes ? _self.workoutNotes : workoutNotes // ignore: cast_nullable_to_non_nullable
as String?,shouldSupersetWithNext: null == shouldSupersetWithNext ? _self.shouldSupersetWithNext : shouldSupersetWithNext // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}


}

// dart format on
