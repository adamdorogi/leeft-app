import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';

/// A screen displaying application settings.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
    );
  }
}
