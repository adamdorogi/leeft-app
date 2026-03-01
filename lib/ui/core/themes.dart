import 'package:flutter/material.dart';

/// A collection of themes.
abstract final class Themes {
  /// The theme for the light [ThemeMode].
  static final lightTheme = ThemeData();

  /// The theme for the dark [ThemeMode].
  static final darkTheme = ThemeData(brightness: .dark);
}
