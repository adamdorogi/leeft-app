import 'dart:async';

import 'package:flutter/material.dart';

import 'package:leeft/data/repositories/theme/theme_repository.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the settings screen.
class SettingsViewModel extends ChangeNotifier {
  /// Creates a [SettingsViewModel] with a [themeRepository].
  ///
  /// The [themeRepository] retrieves and stores the theme data.
  SettingsViewModel({required ThemeRepository themeRepository})
    : _themeRepository = themeRepository;

  final ThemeRepository _themeRepository;

  final _log = Logger((SettingsViewModel).toString());

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
        return const Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to load view model: $error');
        return Result.failure(error);
    }
  }

  /// The command to set the theme mode in the theme repository.
  late final Command1<void, String?> setThemeMode = Command1(_setThemeMode);
  Future<Result<void>> _setThemeMode(String? themeMode) async {
    if (_themeMode == themeMode || themeMode == null) {
      return const Result.success(null);
    }

    _log.info('Setting theme mode to $themeMode...');
    final result = await _themeRepository.setThemeMode(themeMode);

    switch (result) {
      case Success():
        _themeMode = themeMode;
        _log.info('Successfully set theme mode to $themeMode.');
        return const Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to set theme mode: $error');
        return Result.failure(error);
    }
  }
}
