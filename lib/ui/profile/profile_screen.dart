import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/router/routes.dart';

/// A screen displaying the user profile.
class ProfileScreen extends StatelessWidget {
  /// Creates a [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile),
        actions: [
          // Link to settings page.
          IconButton(
            onPressed: () => context.go(Routes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
