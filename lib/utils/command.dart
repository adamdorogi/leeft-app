import 'package:flutter/material.dart';

import 'package:leeft/utils/result.dart';

/// A command with an action.
///
/// The command exposes the action's [result] and [isRunning] state.
///
/// Use [Command0] for actions with no arguments.
/// Use [Command1] for actions with one argument.
abstract class Command<T> extends ChangeNotifier {
  /// The result of the command execution.
  Result<T>? get result => _result;
  Result<T>? _result;

  /// Whether the command action is running.
  bool get isRunning => _isRunning;
  bool _isRunning = false;

  /// Runs the action.
  Future<void> _run(Future<Result<T>> Function() action) async {
    if (_isRunning) {
      return;
    }

    _isRunning = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } on Exception catch (e) {
      _result = Result.failure(e);
    } finally {
      _isRunning = false;
      notifyListeners();
    }
  }
}

/// A [Command] with an action that takes no arguments and returns a result of
/// type [T].
class Command0<T> extends Command<T> {
  /// Creates a [Command0] with an action to be executed.
  ///
  /// The action takes no arguments and returns a result of type [T].
  Command0(this._action);

  final Future<Result<T>> Function() _action;

  /// Runs the action.
  Future<void> run() => _run(_action);
}

/// A [Command] with an action that takes one argument of type [A] and returns
/// a result of type [T].
class Command1<T, A> extends Command<T> {
  /// Creates a [Command1] with an action to be executed.
  ///
  /// The action takes one argument of type [A] and returns a result of type
  /// [T].
  Command1(this._action);

  final Future<Result<T>> Function(A) _action;

  /// Runs the action with an [argument].
  Future<void> run(A argument) => _run(() => _action(argument));
}
