import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/add_exercises/add_exercises_viewmodel.dart';
import 'package:leeft/ui/exercise_details/exercise_details_screen.dart';
import 'package:leeft/ui/exercise_details/exercise_details_viewmodel.dart';
import 'package:leeft/utils/result.dart';

import 'package:provider/provider.dart';

/// A screen for adding exercises to a routine during routine creation.
class AddExercisesScreen extends StatefulWidget {
  /// Creates an [AddExercisesScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const AddExercisesScreen({
    required AddExercisesViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final AddExercisesViewModel _viewModel;

  @override
  State<AddExercisesScreen> createState() => _AddExercisesScreenState();
}

class _AddExercisesScreenState extends State<AddExercisesScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Listen to the view model and its load command.
    return ListenableBuilder(
      listenable: Listenable.merge([widget._viewModel, widget._viewModel.load]),
      builder: (_, child) {
        if (widget._viewModel.load.result is Success<Null>) {
          // View model has loaded successfully, display the list of
          // exercises.
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).addExercises),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(103),
                child: Column(
                  children: [
                    // Search text field.
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).search,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: controller.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  controller.clear();
                                  widget._viewModel.setSearchResults(
                                    controller.text,
                                    AppLocalizations.of(
                                      context,
                                    ).localeName,
                                  );
                                },
                                icon: const Icon(Icons.clear),
                              ),
                      ),
                      onChanged: (_) => widget._viewModel.setSearchResults(
                        controller.text,
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
                              widget._viewModel.selectedMuscleGroups.isNotEmpty,
                          onSelected: (_) => _showMuscleGroupFilters(),
                        ),
                        // Equipment filter chip.
                        FilterChip(
                          label: Text(
                            AppLocalizations.of(context).equipment,
                          ),
                          selected:
                              widget._viewModel.selectedEquipment.isNotEmpty,
                          onSelected: (_) => _showEquipmentFilters(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: widget._viewModel.selectedExerciseIds.isEmpty
                      ? null
                      : () =>
                            // Return the selected exercise IDs on pop.
                            Navigator.of(
                              context,
                            ).pop(widget._viewModel.selectedExerciseIds),
                ),
              ],
            ),
            body: ListView.builder(
              keyboardDismissBehavior: .onDrag,
              itemBuilder: (_, index) {
                final exercise = widget._viewModel.searchResults[index];
                final thumbnailBytes =
                    widget._viewModel.thumbnailBytes[exercise.id];
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
                  selected: widget._viewModel.isExerciseIdSelected(exercise.id),
                  onTap: () => widget._viewModel.toggleExerciseIdSelectionFor(
                    exercise.id,
                  ),
                  selectedTileColor: Theme.of(context).highlightColor,
                  leading: thumbnailBytes != null
                      ? CircleAvatar(
                          foregroundImage: MemoryImage(thumbnailBytes),
                        )
                      : const CircleAvatar(
                          child: Icon(Icons.fitness_center),
                        ),
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
              itemCount: widget._viewModel.searchResults.length,
            ),
          );
        }

        // View model is loading or has failed to load, display empty screen.
        return child!;
      },
      child: const Scaffold(),
    );
  }

  Future<void> _showMuscleGroupFilters() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListenableBuilder(
        listenable: widget._viewModel,
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
                children: widget._viewModel.muscleGroups
                    .map(
                      (muscleGroup) => FilterChip(
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).muscleGroupNameFor(
                            muscleGroup,
                          ),
                        ),
                        selected: widget._viewModel.isMuscleGroupSelected(
                          muscleGroup,
                        ),
                        onSelected: (_) {
                          widget._viewModel.toggleMuscleGroupSelectionFor(
                            muscleGroup,
                          );
                          widget._viewModel.setSearchResults(
                            controller.text,
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

  Future<void> _showEquipmentFilters() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListenableBuilder(
        listenable: widget._viewModel,
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
                children: widget._viewModel.equipment
                    .map(
                      (equipment) => FilterChip(
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).equipmentNameFor(equipment),
                        ),
                        selected: widget._viewModel.isEquipmentSelected(
                          equipment,
                        ),
                        onSelected: (_) {
                          widget._viewModel.toggleEquipmentSelectionFor(
                            equipment,
                          );
                          widget._viewModel.setSearchResults(
                            controller.text,
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
