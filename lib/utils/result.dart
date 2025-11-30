/// A [Result], which can either be [Success] or [Failure].
sealed class Result<T> {
  const Result();

  factory Result.success(T value) = Success._;

  factory Result.failure(Exception error) = Failure._;
}

/// A [Success] [Result] with a [value].
class Success<T> extends Result<T> {
  const Success._(this.value);

  /// The value.
  final T value;
}

/// A [Failure] [Result] with an [error].
class Failure<T> extends Result<T> {
  const Failure._(this.error);

  /// The error.
  final Exception error;
}
