import 'package:flutter/material.dart';

/// A collection of themes.
abstract final class Themes {
  static const InteractiveInkFeatureFactory _splashFactory =
      NoSplash.splashFactory;

  /// The theme for the light [ThemeMode].
  static final lightTheme = ThemeData(splashFactory: _splashFactory);

  /// The theme for the dark [ThemeMode].
  static final darkTheme = ThemeData(
    brightness: .dark,
    splashFactory: _splashFactory,
  );
}
