import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/router/router.dart';
import 'package:leeft/ui/app/app_viewmodel.dart';
import 'package:leeft/ui/core/themes.dart';

/// A Flutter application for tracking gym workouts.
class App extends StatelessWidget {
  /// Creates an [App].
  const App({required AppViewModel viewModel, super.key})
    : _viewModel = viewModel;

  final AppViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_viewModel, _viewModel.load]),
      builder: (_, _) => MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: switch (_viewModel.themeMode) {
          'dark' => ThemeMode.dark,
          'light' => ThemeMode.light,
          _ => ThemeMode.system,
        },
      ),
    );
  }
}
