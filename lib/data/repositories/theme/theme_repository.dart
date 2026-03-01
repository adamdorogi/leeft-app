import 'package:leeft/utils/result.dart';

/// A repository for managing theme data.
abstract class ThemeRepository {
  /// Stream that emits theme mode changes.
  Stream<String> observeThemeMode();

  /// The current theme mode.
  Future<Result<String?>> get themeMode;

  /// Sets the current [themeMode].
  Future<Result<void>> setThemeMode(String themeMode);
}
