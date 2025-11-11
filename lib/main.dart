import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leeft/config/dependencies.dart';
import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/routing/router.dart';

void main() {
  runApp(
    // Use dependency injection to expose services and repositories as
    // [Provider] objects to the top level of the widget tree of [MainApp].
    MultiProvider(providers: providersLocal, child: const MainApp()),
  );
}

/// A Flutter application for tracking gym workouts.
class MainApp extends StatelessWidget {
  /// Creates a [MainApp].
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData.dark(),
    );
  }
}
