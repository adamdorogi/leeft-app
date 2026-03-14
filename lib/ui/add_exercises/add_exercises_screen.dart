import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:relift/ui/add_exercises/widgets/bottom_sheet_filter_chip.dart';
import 'package:relift/ui/add_exercises/widgets/filter_bottom_sheet.dart';
import 'package:relift/ui/core/widgets/app_sliver_app_bar.dart';
import 'package:relift/ui/core/widgets/exercise_thumbnail.dart';
import 'package:relift/ui/exercise_details/exercise_details_screen.dart';
import 'package:relift/ui/exercise_details/exercise_details_viewmodel.dart';
import 'package:relift/utils/result.dart';

/// A screen for adding exercises to a routine during routine creation.
class AddExercisesScreen extends StatelessWidget {
  /// Creates an [AddExercisesScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const AddExercisesScreen({
    required AddExercisesViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final AddExercisesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) => CustomScrollView(
          keyboardDismissBehavior: .onDrag,
          slivers: [
            // App bar.
            AppSliverAppBar(
              title: Text(AppLocalizations.of(context).addExercises),
              actions: [
                IconButton(
                  icon: const Icon(Icons.done),
                  // Return the selected exercise IDs on pop.
                  onPressed: _viewModel.selectedExerciseIds.isEmpty
                      ? null
                      : () => Navigator.of(
                          context,
                        ).pop(_viewModel.selectedExerciseIds),
                ),
              ],
            ),
            // Search bar.
            PinnedHeaderSliver(
              child: Column(
                children: [
                  // Search text field.
                  TextField(
                    controller: _viewModel.searchController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).search,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _viewModel.searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: _viewModel.searchController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                    ),
                  ),
                  // Filter chips.
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      // Muscle group filter chip.
                      BottomSheetFilterChip(
                        label: AppLocalizations.of(context).muscleGroups,
                        selectedCount: _viewModel.selectedMuscleGroups.length,
                        onClear: _viewModel.clearSelectedMuscleGroups,
                        builder: (context) => FilterBottomSheet(
                          listenable: _viewModel,
                          title: Text(
                            AppLocalizations.of(context).muscleGroups,
                          ),
                          items: _viewModel.muscleGroups,
                          labelBuilder: (item) => Text(
                            AppLocalizations.of(
                              context,
                            ).muscleGroupNameFor(item),
                          ),
                          isSelected: _viewModel.selectedMuscleGroups.contains,
                          onSelected: _viewModel.toggleMuscleGroupSelectionFor,
                        ),
                      ),
                      // Equipment filter chip.
                      BottomSheetFilterChip(
                        label: AppLocalizations.of(context).equipment,
                        selectedCount: _viewModel.selectedEquipment.length,
                        onClear: _viewModel.clearSelectedEquipment,
                        builder: (context) => FilterBottomSheet(
                          listenable: _viewModel,
                          title: Text(
                            AppLocalizations.of(context).equipment,
                          ),
                          items: _viewModel.equipment,
                          labelBuilder: (item) => Text(
                            AppLocalizations.of(
                              context,
                            ).equipmentNameFor(item),
                          ),
                          isSelected: _viewModel.selectedEquipment.contains,
                          onSelected: _viewModel.toggleEquipmentSelectionFor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Exercise list.
            child!,
          ],
        ),
        child: ListenableBuilder(
          listenable: Listenable.merge([_viewModel.load, _viewModel]),
          builder: (context, _) {
            if (_viewModel.load.result is! Success<void>) {
              // View model hasn't loaded yet.
              return const SliverToBoxAdapter();
            }

            // View model has loaded successfully, display the list of
            // exercises.
            final filteredExercises = _viewModel.filteredExercises(
              AppLocalizations.of(context).localeName,
            );
            return SliverList.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                // Exercise.
                final exercise = filteredExercises[index];
                return ListTile(
                  title: Text(
                    exercise.title.forLocale(
                      AppLocalizations.of(context).localeName,
                    ),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(
                      context,
                    ).muscleGroupNameFor(exercise.muscleGroup),
                  ),
                  selected: _viewModel.selectedExerciseIds.contains(
                    exercise.id,
                  ),
                  onTap: () => _viewModel.toggleExerciseIdSelectionFor(
                    exercise.id,
                  ),
                  selectedTileColor: Theme.of(context).highlightColor,
                  leading: ExerciseThumbnail(
                    thumbnailUrl: exercise.thumbnailUrl,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) {
                            final viewModel = ExerciseDetailsViewModel(
                              exerciseRepository: context.read(),
                            );
                            // No need to wait for load command to finish.
                            // ignore: discarded_futures
                            viewModel.load.run(exercise.id);
                            // No need to wait for load command to finish.
                            // ignore: discarded_futures
                            viewModel.loadMedia.run(exercise.mediaUrl);
                            return ExerciseDetailsScreen(
                              viewModel: viewModel,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
