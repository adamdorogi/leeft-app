/// A collection of route paths.
abstract final class Routes {
  /// The route path of the Routines page.
  static const routines = '/routines';

  /// The route path of the Profile page.
  static const profile = '/profile';

  /// The route path of the Settings page, relative to the Profile page.
  static const settingsRelative = '/settings';

  /// The route path of the Settings page.
  static const settings = '$profile$settingsRelative';
}
