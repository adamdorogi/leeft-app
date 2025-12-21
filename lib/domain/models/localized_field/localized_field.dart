import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_field.freezed.dart';
part 'localized_field.g.dart';

/// A localized field of type [T].
@Freezed(genericArgumentFactories: true)
abstract class LocalizedField<T> with _$LocalizedField<T> {
  /// Creates a [LocalizedField].
  const factory LocalizedField({required T en}) = _LocalizedField;

  const LocalizedField._();

  /// The [LocalizedField] created from [json].
  factory LocalizedField.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$LocalizedFieldFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(
    Object? Function(T) toJsonT,
  );

  /// The field for the [localeName].
  T forLocale(String localeName) {
    return switch (localeName) {
          _ => null,
        } ??
        en;
  }
}
