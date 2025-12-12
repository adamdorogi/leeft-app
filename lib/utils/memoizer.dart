import 'package:leeft/utils/result.dart';

/// A memoizer with an action.
///
/// The memoizer deduplicates the action and caches its result in memory.
///
/// Use [Memoizer0] for actions with no arguments.
/// Use [Memoizer1] for actions with one argument.
abstract class Memoizer<V, K> {
  final Map<K, Future<Result<V>>> _cachedResults = {};

  Future<Result<V>> _run(K key, Future<Result<V>> Function() action) async {
    // Return the action's result if it has been cached.
    final cachedResult = _cachedResults[key];
    if (cachedResult != null) {
      return cachedResult;
    }

    try {
      // Execute the action.
      final inflightResult = action();
      _cachedResults[key] = inflightResult;
      final result = await inflightResult;

      // Only cache successful results.
      if (result is Failure<V>) {
        // Removed value is not needed.
        // ignore: unawaited_futures
        _cachedResults.remove(key);
      }
      return result;
    } on Exception catch (e) {
      // Removed value is not needed.
      // ignore: unawaited_futures
      _cachedResults.remove(key);
      return Result.failure(e);
    }
  }
}

/// A [Memoizer] with an action that takes no arguments and returns a result of
/// type [T].
class Memoizer0<T> extends Memoizer<T, Null> {
  /// Creates a [Memoizer0] with an action to be memoized.
  ///
  /// The action takes no arguments and returns a result of type [T].
  Memoizer0(this._action);

  final Future<Result<T>> Function() _action;

  /// Invoke the action.
  Future<Result<T>> run() => _run(null, _action);
}

/// A [Memoizer] with an action that takes one argument of type [A] and returns
/// a result of type [T].
class Memoizer1<T, A extends Object> extends Memoizer<T, A> {
  /// Creates a [Memoizer1] with an action to be memoized.
  ///
  /// The action takes one argument of type [A] and returns a result of type
  /// [T].
  Memoizer1(this._action);

  final Future<Result<T>> Function(A) _action;

  /// Invoke the action with an [argument].
  Future<Result<T>> run(A argument) => _run(argument, () => _action(argument));
}
