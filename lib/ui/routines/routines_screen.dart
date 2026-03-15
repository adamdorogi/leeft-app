import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/core/dimens.dart';
import 'package:relift/ui/core/widgets/app_sliver_app_bar.dart';
import 'package:relift/ui/core/widgets/routine_options_menu.dart';
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
          AppSliverAppBar(title: Text(AppLocalizations.of(context).routines)),
          // Routines.
          ListenableBuilder(
            listenable: Listenable.merge([
              _viewModel.load,
              _viewModel.deleteRoutine,
            ]),
            builder: (_, _) => SliverList.builder(
              itemBuilder: (context, index) {
                final routine = _viewModel.routines[index];
                // Routine.
                return Padding(
                  padding: const .symmetric(
                    horizontal: Dimens.padding2,
                    vertical: Dimens.padding1,
                  ),
                  child: Card(
                    clipBehavior: .hardEdge,
                    child: InkWell(
                      child: Padding(
                        padding: const .all(Dimens.padding2),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              routine.name ??
                                  AppLocalizations.of(context).newRoutine,
                            ),
                            RoutineOptionsMenu(
                              onEdit: () async {
                                await Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).push(
                                  MaterialPageRoute<void>(
                                    fullscreenDialog: true,
                                    builder: (_) {
                                      final viewModel = RoutineFormViewModel(
                                        exerciseRepository: context.read(),
                                        routineRepository: context.read(),
                                      );
                                      // No need to wait for load command to
                                      // finish.
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
                              onDelete: () =>
                                  _viewModel.deleteRoutine.run(routine.id),
                            ),
                          ],
                        ),
                      ),
                    ),
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
