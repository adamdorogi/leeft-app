import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';

class AddExercisesScreen extends StatelessWidget {
  const AddExercisesScreen({super.key, required this.viewModel});

  final AddExercisesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.addExercises)),
      body: ListenableBuilder(
        listenable: viewModel.load,
        builder: (_, child) {
          if (viewModel.load.value.isFailure) {
            return const Center(child: Text('Error'));
          }

          if (viewModel.load.value.isRunning) {
            return const Center(child: Text('Loading'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (_, _) => ListView.builder(
            itemBuilder: (_, index) =>
                ListTile(title: Text(viewModel.exercises[index].name)),
            itemCount: viewModel.exercises.length,
          ),
        ),
      ),
    );
  }
}
