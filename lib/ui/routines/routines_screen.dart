import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/routine_form/routine_form_screen.dart';
import 'package:relift/ui/routine_form/routine_form_viewmodel.dart';
import 'package:relift/ui/routines/routines_viewmodel.dart';

/// A screen displaying saved routines.
class RoutinesScreen extends StatelessWidget {
  /// Creates a [RoutinesScreen].
  const RoutinesScreen({required RoutinesViewModel viewModel, super.key})
    : _viewModel = viewModel;

  final RoutinesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar.
          SliverAppBar(title: Text(AppLocalizations.of(context).routines)),
          // Routines.
          ListenableBuilder(
            listenable: Listenable.merge([
              _viewModel.load,
              _viewModel.deleteRoutine,
            ]),
            builder: (_, _) => SliverList.builder(
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
                        onPressed: () =>
                            _viewModel.deleteRoutine.run(routine.id),
                        leadingIcon: const Icon(Icons.delete),
                        child: Text(
                          AppLocalizations.of(context).remove,
                        ),
                      ),
                      MenuItemButton(
                        onPressed: () async {
                          await Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute<void>(
                              fullscreenDialog: true,
                              builder: (_) {
                                final viewModel = RoutineFormViewModel(
                                  exerciseRepository: context.read(),
                                  routineRepository: context.read(),
                                );
                                // No need to wait for load command to finish.
                                // ignore: discarded_futures
                                viewModel.load.run(routine.id);
                                return RoutineFormScreen(
                                  viewModel: viewModel,
                                );
                              },
                            ),
                          );
                          // Reload page after pop.
                          await _viewModel.load.run();
                        },
                        leadingIcon: const Icon(Icons.edit),
                        child: Text(AppLocalizations.of(context).edit),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _viewModel.routines.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).createRoutine),
        onPressed: () async {
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (_) {
                final viewModel = RoutineFormViewModel(
                  exerciseRepository: context.read(),
                  routineRepository: context.read(),
                );
                // No need to wait for load command to finish.
                // ignore: discarded_futures
                viewModel.load.run(null);
                return RoutineFormScreen(viewModel: viewModel);
              },
            ),
          );
          // Reload page after pop.
          await _viewModel.load.run();
        },
      ),
    );
  }
}
