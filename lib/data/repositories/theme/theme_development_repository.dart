import 'dart:async';

import 'package:leeft/data/repositories/theme/theme_repository.dart';
import 'package:leeft/data/services/shared_preferences_service.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A [ThemeRepository] for development.
class ThemeDevelopmentRepository extends ThemeRepository {
  /// Creates a [ThemeDevelopmentRepository] with a [sharedPreferencesService].
  ///
  /// The [sharedPreferencesService] manages the theme in the shared
  /// preferences.
  ThemeDevelopmentRepository({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final _log = Logger((ThemeDevelopmentRepository).toString());

  final SharedPreferencesService _sharedPreferencesService;

  @override
  Stream<String> observeThemeMode() => _themeModeController.stream;
  final _themeModeController = StreamController<String>.broadcast();

  @override
  Future<Result<String?>> get themeMode async {
    final result = await _sharedPreferencesService.themeMode;

    switch (result) {
      case Success(value: final themeMode):
        _log.info('Successfully retrieved theme mode $themeMode.');
        return Result.success(themeMode);
      case Failure(:final error):
        _log.warning('Failed to retrieve theme mode: $error');
        return Result.failure(error);
    }
  }

  @override
  Future<Result<void>> setThemeMode(String themeMode) async {
    final result = await _sharedPreferencesService.setThemeMode(themeMode);

    switch (result) {
      case Success():
        _themeModeController.add(themeMode);
        _log.info('Successfully set theme mode $themeMode.');
        return Result.success(null);
      case Failure(:final error):
        _log.warning('Failed to set theme mode: $error');
        return Result.failure(error);
    }
  }
}
