import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/create_routine/create_routine_screen.dart';
import 'package:leeft/ui/create_routine/create_routine_viewmodel.dart';
import 'package:leeft/ui/routines/routines_viewmodel.dart';

import 'package:provider/provider.dart';

/// A screen displaying saved routines.
class RoutinesScreen extends StatelessWidget {
  /// Creates a [RoutinesScreen].
  const RoutinesScreen({required RoutinesViewModel viewModel, super.key})
    : _viewModel = viewModel;

  final RoutinesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).routines)),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          _viewModel.load,
          _viewModel.deleteRoutine,
        ]),
        builder: (context, _) => ListView.builder(
          itemBuilder: (context, index) {
            final routine = _viewModel.routines[index];
            return ListTile(
              title: Text(
                routine.name ?? AppLocalizations.of(context).newRoutine,
              ),
              trailing: MenuAnchor(
                builder: (_, controller, _) => IconButton(
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  icon: const Icon(Icons.more_horiz),
                ),
                menuChildren: [
                  MenuItemButton(
                    onPressed: () => _viewModel.deleteRoutine.run(routine.id),
                    leadingIcon: const Icon(Icons.delete),
                    child: Text(
                      AppLocalizations.of(context).remove,
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: _viewModel.routines.length,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).createRoutine),
        onPressed: () async {
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (_) => CreateRoutineScreen(
                viewModel: CreateRoutineViewModel(
                  exerciseRepository: context.read(),
                  routineRepository: context.read(),
                ),
              ),
            ),
          );
          await _viewModel.load.run();
        },
      ),
    );
  }
}
