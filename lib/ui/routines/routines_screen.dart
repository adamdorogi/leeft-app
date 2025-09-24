import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.routines)),
    );
  }
}
