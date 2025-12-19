import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/router/router.dart';
import 'package:leeft/ui/core/themes.dart';

/// A Flutter application for tracking gym workouts.
class App extends StatelessWidget {
  /// Creates an [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
    );
  }
}
