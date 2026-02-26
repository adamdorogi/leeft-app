// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoutineExercise _$RoutineExerciseFromJson(Map<String, dynamic> json) {
  return _RoutineExercise.fromJson(json);
}

/// @nodoc
mixin _$RoutineExercise {
  String? get exerciseId => throw _privateConstructorUsedError;
  List<ExerciseSet> get sets => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get shouldSupersetWithNext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutineExerciseCopyWith<RoutineExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineExerciseCopyWith<$Res> {
  factory $RoutineExerciseCopyWith(
          RoutineExercise value, $Res Function(RoutineExercise) then) =
      _$RoutineExerciseCopyWithImpl<$Res, RoutineExercise>;
  @useResult
  $Res call(
      {String? exerciseId,
      List<ExerciseSet> sets,
      String? notes,
      bool shouldSupersetWithNext});
}

/// @nodoc
class _$RoutineExerciseCopyWithImpl<$Res, $Val extends RoutineExercise>
    implements $RoutineExerciseCopyWith<$Res> {
  _$RoutineExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = freezed,
    Object? sets = null,
    Object? notes = freezed,
    Object? shouldSupersetWithNext = null,
  }) {
    return _then(_value.copyWith(
      exerciseId: freezed == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String?,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      shouldSupersetWithNext: null == shouldSupersetWithNext
          ? _value.shouldSupersetWithNext
          : shouldSupersetWithNext // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineExerciseImplCopyWith<$Res>
    implements $RoutineExerciseCopyWith<$Res> {
  factory _$$RoutineExerciseImplCopyWith(_$RoutineExerciseImpl value,
          $Res Function(_$RoutineExerciseImpl) then) =
      __$$RoutineExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? exerciseId,
      List<ExerciseSet> sets,
      String? notes,
      bool shouldSupersetWithNext});
}

/// @nodoc
class __$$RoutineExerciseImplCopyWithImpl<$Res>
    extends _$RoutineExerciseCopyWithImpl<$Res, _$RoutineExerciseImpl>
    implements _$$RoutineExerciseImplCopyWith<$Res> {
  __$$RoutineExerciseImplCopyWithImpl(
      _$RoutineExerciseImpl _value, $Res Function(_$RoutineExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = freezed,
    Object? sets = null,
    Object? notes = freezed,
    Object? shouldSupersetWithNext = null,
  }) {
    return _then(_$RoutineExerciseImpl(
      exerciseId: freezed == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String?,
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      shouldSupersetWithNext: null == shouldSupersetWithNext
          ? _value.shouldSupersetWithNext
          : shouldSupersetWithNext // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineExerciseImpl implements _RoutineExercise {
  const _$RoutineExerciseImpl(
      {this.exerciseId,
      final List<ExerciseSet> sets = const [],
      this.notes,
      this.shouldSupersetWithNext = false})
      : _sets = sets;

  factory _$RoutineExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineExerciseImplFromJson(json);

  @override
  final String? exerciseId;
  final List<ExerciseSet> _sets;
  @override
  @JsonKey()
  List<ExerciseSet> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  final String? notes;
  @override
  @JsonKey()
  final bool shouldSupersetWithNext;

  @override
  String toString() {
    return 'RoutineExercise(exerciseId: $exerciseId, sets: $sets, notes: $notes, shouldSupersetWithNext: $shouldSupersetWithNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineExerciseImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            const DeepCollectionEquality().equals(other._sets, _sets) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.shouldSupersetWithNext, shouldSupersetWithNext) ||
                other.shouldSupersetWithNext == shouldSupersetWithNext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      exerciseId,
      const DeepCollectionEquality().hash(_sets),
      notes,
      shouldSupersetWithNext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineExerciseImplCopyWith<_$RoutineExerciseImpl> get copyWith =>
      __$$RoutineExerciseImplCopyWithImpl<_$RoutineExerciseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineExerciseImplToJson(
      this,
    );
  }
}

abstract class _RoutineExercise implements RoutineExercise {
  const factory _RoutineExercise(
      {final String? exerciseId,
      final List<ExerciseSet> sets,
      final String? notes,
      final bool shouldSupersetWithNext}) = _$RoutineExerciseImpl;

  factory _RoutineExercise.fromJson(Map<String, dynamic> json) =
      _$RoutineExerciseImpl.fromJson;

  @override
  String? get exerciseId;
  @override
  List<ExerciseSet> get sets;
  @override
  String? get notes;
  @override
  bool get shouldSupersetWithNext;
  @override
  @JsonKey(ignore: true)
  _$$RoutineExerciseImplCopyWith<_$RoutineExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
