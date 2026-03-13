import 'package:flutter/material.dart';

import 'package:relift/l10n/app_localizations.dart';
import 'package:relift/ui/core/dimens.dart';
import 'package:relift/ui/core/widgets/app_sliver_app_bar.dart';
import 'package:relift/ui/exercise_details/exercise_details_viewmodel.dart';

import 'package:video_player/video_player.dart';

/// A screen for viewing exercise details.
class ExerciseDetailsScreen extends StatelessWidget {
  /// Creates an [ExerciseDetailsScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const ExerciseDetailsScreen({
    required ExerciseDetailsViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final ExerciseDetailsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _viewModel.load,
        builder: (context, child) {
          final exercise = _viewModel.exercise;
          if (exercise == null) {
            // Exercise hasn't been loaded yet.
            return const CustomScrollView();
          }
          return CustomScrollView(
            slivers: [
              AppSliverAppBar(
                title: Text(
                  exercise.title.forLocale(
                    AppLocalizations.of(context).localeName,
                  ),
                ),
              ),
              // Media.
              child!,
              // Metadata.
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    // Exercise equipment.
                    Chip(
                      materialTapTargetSize: .shrinkWrap,
                      avatar: const Icon(Icons.fitness_center),
                      label: Text(
                        AppLocalizations.of(
                          context,
                        ).equipmentNameFor(exercise.equipment),
                      ),
                    ),
                    // Primary muscle group.
                    Chip(
                      materialTapTargetSize: .shrinkWrap,
                      avatar: const Icon(Icons.looks_one),
                      label: Text(
                        AppLocalizations.of(
                          context,
                        ).muscleGroupNameFor(exercise.muscleGroup),
                      ),
                    ),
                    // Secondary muscle groups.
                    for (final muscleGroup in exercise.otherMuscles)
                      Chip(
                        materialTapTargetSize: .shrinkWrap,
                        avatar: const Icon(Icons.looks_two),
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).muscleGroupNameFor(muscleGroup),
                        ),
                      ),
                  ],
                ),
              ),
              // Instructions.
              SliverList.builder(
                itemBuilder: (_, index) => ListTile(
                  leading: Text('${index + 1}.'),
                  title: Text(
                    exercise.instructions.forLocale(
                      AppLocalizations.of(context).localeName,
                    )[index],
                  ),
                ),
                itemCount: exercise.instructions
                    .forLocale(AppLocalizations.of(context).localeName)
                    .length,
              ),
            ],
          );
        },
        child: SliverToBoxAdapter(
          child: ListenableBuilder(
            listenable: _viewModel.loadMedia,
            builder: (_, _) {
              // Video.
              final videoController = _viewModel.videoController;
              if (videoController != null) {
                return AspectRatio(
                  aspectRatio: Dimens.mediaAspectRatio,
                  child: VideoPlayer(videoController),
                );
              }

              // Image.
              final imagePath = _viewModel.imagePath;
              if (imagePath != null) {
                return Image.asset(imagePath);
              }

              // No media.
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
