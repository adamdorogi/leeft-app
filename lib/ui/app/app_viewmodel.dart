import 'dart:async';

import 'package:flutter/material.dart';

import 'package:leeft/data/repositories/theme/theme_repository.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the app.
class AppViewModel extends ChangeNotifier {
  /// Creates an [AppViewModel] with a [themeRepository].
  ///
  /// The [themeRepository] retrieves the theme data.
  AppViewModel({required ThemeRepository themeRepository})
    : _themeRepository = themeRepository {
    _themeModeSubscription = _themeRepository.observeThemeMode().listen(
      _setThemeMode,
    );
  }

  final ThemeRepository _themeRepository;

  StreamSubscription<String>? _themeModeSubscription;

  final _log = Logger((AppViewModel).toString());

  /// The current theme mode.
  String? get themeMode => _themeMode;
  String? _themeMode;

  /// The command to load the theme mode from the theme repository.
  late final Command0<void> load = Command0(_load);
  Future<Result<void>> _load() async {
    _log.info('Loading view model...');
    final themeModeResult = await _themeRepository.themeMode;

    switch (themeModeResult) {
      case Success(value: final themeMode):
        _themeMode = themeMode;
        _log.info('Successfully loaded view model.');
        return Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to load view model: $error');
        return Result.failure(error);
    }
  }

  void _setThemeMode(String themeMode) {
    if (_themeMode == themeMode) {
      return;
    }

    _themeMode = themeMode;
    _log.info('Successfully set theme mode to $themeMode.');
    notifyListeners();
  }

  @override
  void dispose() {
    // No need to wait for stream cleanup.
    // ignore: discarded_futures
    _themeModeSubscription?.cancel();
    super.dispose();
  }
}
