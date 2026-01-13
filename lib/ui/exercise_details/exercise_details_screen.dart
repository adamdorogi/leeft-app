import 'package:flutter/material.dart';

import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/ui/exercise_details/exercise_details_viewmodel.dart';

import 'package:video_player/video_player.dart';

/// A screen for viewing exercise details.
class ExerciseDetailsScreen extends StatefulWidget {
  /// Creates an [ExerciseDetailsScreen] with a [viewModel].
  ///
  /// The [viewModel] manages the UI state of this screen.
  const ExerciseDetailsScreen({
    required ExerciseDetailsViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  final ExerciseDetailsViewModel _viewModel;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  VideoPlayerController? _controller;
  AssetImage? _image;

  @override
  void initState() {
    super.initState();
    widget._viewModel.load.addListener(_onLoaded);
  }

  void _onLoaded() {
    final exercise = widget._viewModel.exercise;
    if (exercise == null) {
      return;
    }
    // Exercise has loaded.

    final mediaUrl = exercise.mediaUrl;
    if (mediaUrl == null) {
      return;
    }
    // Exercise has media URL.

    if (widget._viewModel.isVideo(mediaUrl)) {
      // Media is video.
      _controller = VideoPlayerController.asset(mediaUrl)
        // No need to wait for controller setup to complete.
        // ignore: discarded_futures
        ..setLooping(true)
        // No need to wait for controller setup to complete.
        // ignore: discarded_futures
        ..initialize()
        // No need to wait for controller setup to complete.
        // ignore: discarded_futures
        ..play();
    } else {
      // Media is image.
      _image = AssetImage(mediaUrl);
    }
  }

  @override
  void dispose() {
    widget._viewModel.load.removeListener(_onLoaded);
    // No need to wait for controller disposal to complete.
    // ignore: discarded_futures
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._viewModel.load,
      builder: (_, child) {
        final exercise = widget._viewModel.exercise;
        if (exercise != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                exercise.title.forLocale(
                  AppLocalizations.of(context).localeName,
                ),
              ),
            ),
            body: ListView(
              children: [
                if (_controller case final controller?)
                  AspectRatio(
                    aspectRatio: 643 / 404,
                    child: VideoPlayer(controller),
                  )
                else if (_image case final image?)
                  Image(image: image),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      // Exercise equipment.
                      Chip(
                        avatar: const Icon(Icons.fitness_center),
                        label: Text(
                          AppLocalizations.of(
                            context,
                          ).equipmentNameFor(exercise.equipment),
                        ),
                      ),
                      // Primary muscle group.
                      Chip(
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
                for (final (i, instruction)
                    in exercise.instructions
                        .forLocale(AppLocalizations.of(context).localeName)
                        .indexed)
                  ListTile(
                    leading: Text('${i + 1}.'),
                    title: Text(instruction),
                  ),
              ],
            ),
          );
        }

        // Exercise hasn't been loaded yet.
        return child!;
      },
      child: const Scaffold(),
    );
  }
}
