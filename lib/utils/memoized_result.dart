import 'package:result_dart/result_dart.dart';

/// A class for making asynchronous calls and memoizing their results in
/// memory.
///
/// Use [MemoizedResult0] for actions with no arguments.
/// Use [MemoizedResult1] for actions with one argument.
abstract class MemoizedResult<T, A> {
  /// Creates a [MemoizedResult].
  ///
  /// Takes initial [_cached] and [_inflight] objects to keep track of the
  /// cached and inflight actions.
  MemoizedResult(this._cached, this._inflight);

  T _cached;
  A _inflight;

  /// Clears the cache and inflight actions.
  void clear();
}

/// A [MemoizedResult] with no arguments and result type of [T].
class MemoizedResult0<T extends Object>
    extends MemoizedResult<T?, AsyncResult<T>?> {
  /// Creates a [MemoizedResult0].
  ///
  /// Takes an [_action] to be memoized.
  MemoizedResult0(this._action) : super(null, null);

  final AsyncResult<T> Function() _action;

  /// Invoke the [_action].
  AsyncResult<T> invoke() async {
    // Check if the result has been cached.
    if (_cached != null) {
      return Success(_cached!);
    }

    // Check if the action is already inflight.
    if (_inflight != null) {
      return _inflight!;
    }

    // No cached result or inflight action, execute the action, and update the
    // cache and inflight accordingly.
    _inflight = _action();
    final result = await _inflight!;
    _cached = result.getOrNull();
    _inflight = null;

    return result;
  }

  @override
  void clear() {
    _cached = null;
    _inflight = null;
  }
}

/// A [MemoizedResult] with one argument, result of type [T], and parameter of
/// type [A].
class MemoizedResult1<T extends Object, A>
    extends MemoizedResult<Map<A, T>, Map<A, AsyncResult<T>>> {
  /// Creates a [MemoizedResult1].
  ///
  /// Takes an [_action] to be memoized.
  MemoizedResult1(this._action) : super({}, {});

  final AsyncResult<T> Function(A) _action;

  /// Invoke the [_action].
  AsyncResult<T> invoke(A param) async {
    // Check if the result has been cached.
    if (_cached[param] != null) {
      return Success(_cached[param]!);
    }

    // Check if the action is already inflight.
    if (_inflight[param] != null) {
      return _inflight[param]!;
    }

    // No cached result or inflight action, execute the action, and update the
    // cache and inflight accordingly.
    _inflight[param] = _action(param);
    final result = await _inflight[param]!;
    if (result.isSuccess()) {
      _cached[param] = result.getOrNull()!;
    }
    await _inflight.remove(param);

    return result;
  }

  @override
  void clear() {
    _cached.clear();
    _inflight.clear();
  }
}
