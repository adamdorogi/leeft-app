/// A result that can either be a [Success] or a [Failure].
sealed class Result<T> {
  const Result();

  /// Creates a [Success] with a [value].
  factory Result.success(T value) = Success._;

  /// Creates a [Failure] with an [error].
  factory Result.failure(Exception error) = Failure._;
}

/// A successful [Result] with a [value].
class Success<T> extends Result<T> {
  const Success._(this.value);

  /// The value.
  final T value;
}

/// A failed [Result] with an [error].
class Failure<T> extends Result<T> {
  const Failure._(this.error);

  /// The error.
  final Exception error;
}
