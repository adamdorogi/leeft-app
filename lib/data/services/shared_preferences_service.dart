import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A stateless service for interacting with the shared preferences.
class SharedPreferencesService {
  static const _themeModeKey = 'themeMode';
  final _log = Logger((SharedPreferencesService).toString());

  /// The theme mode stored in the shared preferences.
  Future<Result<String?>> get themeMode async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final themeMode = sharedPreferences.getString(_themeModeKey);
      _log.finer('Successfully retrieved theme mode $themeMode.');
      return Result.success(themeMode);
    } on Exception catch (e) {
      _log.warning('Failed to retrieve theme mode: $e');
      return Result.failure(e);
    }
  }

  /// Stores the [themeMode] in the shared preferences.
  Future<Result<void>> setThemeMode(String themeMode) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(_themeModeKey, themeMode);
      _log.finer('Successfully set theme mode $themeMode.');
      return const Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to set theme mode: $e');
      return Result.failure(e);
    }
  }
}
