import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';

class AddExercisesScreen extends StatelessWidget {
  const AddExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.addExercises)),
    );
  }
}
