import 'package:go_router/go_router.dart';

import 'package:leeft/router/routes.dart';
import 'package:leeft/ui/navigation/navigation_screen.dart';
import 'package:leeft/ui/profile/profile_screen.dart';
import 'package:leeft/ui/routines/routines_screen.dart';
import 'package:leeft/ui/settings/settings_screen.dart';

/// The router configuration defining routes and navigation.
final router = GoRouter(
  initialLocation: Routes.routines,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          NavigationScreen(navigationShell: navigationShell),
      branches: [
        // The routines screen.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.routines,
              builder: (_, _) => const RoutinesScreen(),
            ),
          ],
        ),
        // The profile screen.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (_, _) => const ProfileScreen(),
              routes: [
                // The settings screen.
                GoRoute(
                  path: Routes.settingsRelative,
                  builder: (_, _) => const SettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
