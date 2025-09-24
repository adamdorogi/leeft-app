import 'package:go_router/go_router.dart';

import 'package:leeft/routing/routes.dart';
import 'package:leeft/ui/navigation/navigation_screen.dart';
import 'package:leeft/ui/profile/profile_screen.dart';
import 'package:leeft/ui/routines/routines_screen.dart';
import 'package:leeft/ui/settings/settings_screen.dart';

final router = GoRouter(
  initialLocation: Routes.routines,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          NavigationScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.routines,
              builder: (_, _) => const RoutinesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (_, _) => const ProfileScreen(),
              routes: [
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
