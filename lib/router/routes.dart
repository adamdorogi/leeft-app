/// A collection of route paths.
abstract final class Routes {
  /// The route path for the routines screen.
  static const routines = '/routines';

  /// The route path for the profile screen.
  static const profile = '/profile';

  /// The route path for the settings screen, relative to the profile screen.
  static const settingsRelative = '/settings';

  /// The route path for the settings screen.
  static const settings = '$profile$settingsRelative';
}
