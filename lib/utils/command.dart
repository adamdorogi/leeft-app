import 'package:flutter/material.dart';
import 'package:leeft/utils/result.dart';

/// A command that facilitates a view's interaction with a view model.
abstract class Command<T> extends ChangeNotifier {
  /// The result of the command execution.
  Result<T>? get result => _result;
  Result<T>? _result;

  /// Whether the command action is running.
  bool get isRunning => _isRunning;
  bool _isRunning = false;

  /// Whether the command action has failed.
  bool get isFailure => _result is Failure;

  /// Whether the command action has succeeded.
  bool get isSuccess => _result is Success;

  void _execute(Future<Result<T>> Function() action) async {
    if (_isRunning) return;

    _isRunning = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _isRunning = false;
      notifyListeners();
    }
  }
}

/// A [Command] that accepts no arguments.
class Command0<T> extends Command<T> {
  /// Creates a [Command0].
  ///
  /// Takes an action to be executed.
  Command0(this._action);

  final Future<Result<T>> Function() _action;

  /// Executes the action.
  void execute() async {
    _execute(_action);
  }
}

/// A [Command] that accepts one argument.
class Command1<T, A> extends Command<T> {
  /// Creates a [Command1].
  ///
  /// Takes an action to be executed.
  Command1(this._action);

  final Future<Result<T>> Function(A) _action;

  /// Executes the action with [argument].
  void execute(A argument) async {
    _execute(() => _action(argument));
  }
}
