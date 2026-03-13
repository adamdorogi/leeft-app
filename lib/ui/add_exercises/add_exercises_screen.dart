import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/add_exercises/add_exercises_viewmodel.dart';
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
    // Listen to the view model and its load command.
    return ListenableBuilder(
      listenable: Listenable.merge([_viewModel, _viewModel.load]),
      builder: (_, child) {
        if (_viewModel.load.result is Success<void>) {
          // View model has loaded successfully, display the list of
          // exercises.
          return Scaffold(
            body: CustomScrollView(
              keyboardDismissBehavior: .onDrag,
              slivers: [
                AppSliverAppBar(
                  title: Text(AppLocalizations.of(context).addExercises),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(103),
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
                                    onPressed: () {
                                      _viewModel.searchController.clear();
                                      _viewModel.setSearchResults(
                                        _viewModel.searchController.text,
                                        AppLocalizations.of(
                                          context,
                                        ).localeName,
                                      );
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                          ),
                          onChanged: (_) => _viewModel.setSearchResults(
                            _viewModel.searchController.text,
                            AppLocalizations.of(context).localeName,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: .spaceEvenly,
                          children: [
                            // Muscle group filter chip.
                            FilterChip(
                              label: Text(
                                AppLocalizations.of(context).muscleGroups,
                              ),
                              selected:
                                  _viewModel.selectedMuscleGroups.isNotEmpty,
                              onSelected: (_) =>
                                  _showMuscleGroupFilters(context),
                            ),
                            // Equipment filter chip.
                            FilterChip(
                              label: Text(
                                AppLocalizations.of(context).equipment,
                              ),
                              selected: _viewModel.selectedEquipment.isNotEmpty,
                              onSelected: (_) => _showEquipmentFilters(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: _viewModel.selectedExerciseIds.isEmpty
                          ? null
                          : () =>
                                // Return the selected exercise IDs on pop.
                                Navigator.of(
                                  context,
                                ).pop(_viewModel.selectedExerciseIds),
                    ),
                  ],
                ),
                SliverList.builder(
                  itemBuilder: (_, index) {
                    final exercise = _viewModel.searchResults[index];
                    final thumbnailUrl = exercise.thumbnailUrl;
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
                      selected: _viewModel.isExerciseIdSelected(
                        exercise.id,
                      ),
                      onTap: () => _viewModel.toggleExerciseIdSelectionFor(
                        exercise.id,
                      ),
                      selectedTileColor: Theme.of(context).highlightColor,
                      leading: ExerciseThumbnail(thumbnailUrl: thumbnailUrl),
                      trailing: IconButton(
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
                        icon: const Icon(Icons.info_outline),
                      ),
                    );
                  },
                  itemCount: _viewModel.searchResults.length,
                ),
              ],
            ),
          );
        }

        // View model is loading or has failed to load, display empty screen.
        return child!;
      },
      child: const Scaffold(),
    );
  }

  Future<void> _showMuscleGroupFilters(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListenableBuilder(
        listenable: _viewModel,
        builder: (_, child) => Padding(
          padding: const .symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context).muscleGroups,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 8,
                children: _viewModel.muscleGroups
                    .map(
                      (muscleGroup) => FilterChip(
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).muscleGroupNameFor(
                            muscleGroup,
                          ),
                        ),
                        selected: _viewModel.isMuscleGroupSelected(
                          muscleGroup,
                        ),
                        onSelected: (_) {
                          _viewModel.toggleMuscleGroupSelectionFor(
                            muscleGroup,
                          );
                          _viewModel.setSearchResults(
                            _viewModel.searchController.text,
                            AppLocalizations.of(
                              context,
                            ).localeName,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEquipmentFilters(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListenableBuilder(
        listenable: _viewModel,
        builder: (_, child) => Padding(
          padding: const .symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context).equipment,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 8,
                children: _viewModel.equipment
                    .map(
                      (equipment) => FilterChip(
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).equipmentNameFor(equipment),
                        ),
                        selected: _viewModel.isEquipmentSelected(
                          equipment,
                        ),
                        onSelected: (_) {
                          _viewModel.toggleEquipmentSelectionFor(
                            equipment,
                          );
                          _viewModel.setSearchResults(
                            _viewModel.searchController.text,
                            AppLocalizations.of(
                              context,
                            ).localeName,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
