// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  LocalizedField<String> get title => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String get muscleGroup => throw _privateConstructorUsedError;
  List<String> get otherMuscles => throw _privateConstructorUsedError;
  String get exerciseType => throw _privateConstructorUsedError;
  String get equipment => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  LocalizedField<List<String>> get instructions =>
      throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      LocalizedField<String> title,
      int priority,
      String muscleGroup,
      List<String> otherMuscles,
      String exerciseType,
      String equipment,
      String? mediaUrl,
      String? thumbnailUrl,
      LocalizedField<List<String>> instructions,
      List<String> tags});

  $LocalizedFieldCopyWith<String, $Res> get title;
  $LocalizedFieldCopyWith<List<String>, $Res> get instructions;
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? priority = null,
    Object? muscleGroup = null,
    Object? otherMuscles = null,
    Object? exerciseType = null,
    Object? equipment = null,
    Object? mediaUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? instructions = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedField<String>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      muscleGroup: null == muscleGroup
          ? _value.muscleGroup
          : muscleGroup // ignore: cast_nullable_to_non_nullable
              as String,
      otherMuscles: null == otherMuscles
          ? _value.otherMuscles
          : otherMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exerciseType: null == exerciseType
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrl: freezed == mediaUrl
          ? _value.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as LocalizedField<List<String>>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedFieldCopyWith<String, $Res> get title {
    return $LocalizedFieldCopyWith<String, $Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedFieldCopyWith<List<String>, $Res> get instructions {
    return $LocalizedFieldCopyWith<List<String>, $Res>(_value.instructions,
        (value) {
      return _then(_value.copyWith(instructions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LocalizedField<String> title,
      int priority,
      String muscleGroup,
      List<String> otherMuscles,
      String exerciseType,
      String equipment,
      String? mediaUrl,
      String? thumbnailUrl,
      LocalizedField<List<String>> instructions,
      List<String> tags});

  @override
  $LocalizedFieldCopyWith<String, $Res> get title;
  @override
  $LocalizedFieldCopyWith<List<String>, $Res> get instructions;
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? priority = null,
    Object? muscleGroup = null,
    Object? otherMuscles = null,
    Object? exerciseType = null,
    Object? equipment = null,
    Object? mediaUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? instructions = null,
    Object? tags = null,
  }) {
    return _then(_$ExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedField<String>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      muscleGroup: null == muscleGroup
          ? _value.muscleGroup
          : muscleGroup // ignore: cast_nullable_to_non_nullable
              as String,
      otherMuscles: null == otherMuscles
          ? _value._otherMuscles
          : otherMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exerciseType: null == exerciseType
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrl: freezed == mediaUrl
          ? _value.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as LocalizedField<List<String>>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {required this.id,
      required this.title,
      required this.priority,
      required this.muscleGroup,
      required final List<String> otherMuscles,
      required this.exerciseType,
      required this.equipment,
      required this.mediaUrl,
      required this.thumbnailUrl,
      required this.instructions,
      required final List<String> tags})
      : _otherMuscles = otherMuscles,
        _tags = tags;

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String id;
  @override
  final LocalizedField<String> title;
  @override
  final int priority;
  @override
  final String muscleGroup;
  final List<String> _otherMuscles;
  @override
  List<String> get otherMuscles {
    if (_otherMuscles is EqualUnmodifiableListView) return _otherMuscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_otherMuscles);
  }

  @override
  final String exerciseType;
  @override
  final String equipment;
  @override
  final String? mediaUrl;
  @override
  final String? thumbnailUrl;
  @override
  final LocalizedField<List<String>> instructions;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Exercise(id: $id, title: $title, priority: $priority, muscleGroup: $muscleGroup, otherMuscles: $otherMuscles, exerciseType: $exerciseType, equipment: $equipment, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, instructions: $instructions, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.muscleGroup, muscleGroup) ||
                other.muscleGroup == muscleGroup) &&
            const DeepCollectionEquality()
                .equals(other._otherMuscles, _otherMuscles) &&
            (identical(other.exerciseType, exerciseType) ||
                other.exerciseType == exerciseType) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      priority,
      muscleGroup,
      const DeepCollectionEquality().hash(_otherMuscles),
      exerciseType,
      equipment,
      mediaUrl,
      thumbnailUrl,
      instructions,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final String id,
      required final LocalizedField<String> title,
      required final int priority,
      required final String muscleGroup,
      required final List<String> otherMuscles,
      required final String exerciseType,
      required final String equipment,
      required final String? mediaUrl,
      required final String? thumbnailUrl,
      required final LocalizedField<List<String>> instructions,
      required final List<String> tags}) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String get id;
  @override
  LocalizedField<String> get title;
  @override
  int get priority;
  @override
  String get muscleGroup;
  @override
  List<String> get otherMuscles;
  @override
  String get exerciseType;
  @override
  String get equipment;
  @override
  String? get mediaUrl;
  @override
  String? get thumbnailUrl;
  @override
  LocalizedField<List<String>> get instructions;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
