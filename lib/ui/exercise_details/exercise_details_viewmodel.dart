import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';
import 'package:mime/mime.dart';

import 'package:relift/data/repositories/exercise/exercise_repository.dart';
import 'package:relift/domain/models/exercise/exercise.dart';
import 'package:relift/utils/command.dart';
import 'package:relift/utils/result.dart';

import 'package:video_player/video_player.dart';

/// A view model for managing the UI state of the exercise details screen.
class ExerciseDetailsViewModel extends ChangeNotifier {
  /// Creates an [ExerciseDetailsViewModel] with an [exerciseRepository].
  ///
  /// The [exerciseRepository] retrieves the exercise.
  ExerciseDetailsViewModel({
    required ExerciseRepository exerciseRepository,
  }) : _exerciseRepository = exerciseRepository;

  final _log = Logger((ExerciseDetailsViewModel).toString());

  final ExerciseRepository _exerciseRepository;

  /// The exercise.
  Exercise? get exercise => _exercise;
  Exercise? _exercise;

  /// The asset path for the image.
  String? imagePath;

  /// The video controller.
  VideoPlayerController? videoController;

  /// Whether the media asset at [mediaUrl] is a video.
  bool _isVideoAsset(String mediaUrl) => _hasMediaType(mediaUrl, 'video');

  /// Whether the media asset at [mediaUrl] is an image.
  bool _isImageAsset(String mediaUrl) => _hasMediaType(mediaUrl, 'image');

  bool _hasMediaType(String mediaUrl, String mediaType) {
    final mimeType = lookupMimeType(mediaUrl);
    return mimeType != null && mimeType.startsWith('$mediaType/');
  }

  /// The command to load the exercise from the exercise repository.
  late final Command1<void, String> load = Command1(_load);
  Future<Result<void>> _load(String exerciseId) async {
    _log.info('Loading view model...');
    final exerciseResult = await _exerciseRepository.exerciseWith(exerciseId);

    switch (exerciseResult) {
      case Success(value: final exercise):
        _exercise = exercise;
        _log.info('Successfully loaded view model.');
        return const Result.success(null);
      case Failure(:final error):
        _log.info('Failed to load view model: $error');
        return Result.failure(error);
    }
  }

  /// The command to load the exercise from the exercise repository.
  late final Command1<void, String?> loadMedia = Command1(_loadMedia);
  Future<Result<void>> _loadMedia(String? mediaUrl) async {
    await videoController?.dispose();

    if (mediaUrl == null) {
      return const Result.success(null);
    }

    if (_isVideoAsset(mediaUrl)) {
      final controller = VideoPlayerController.asset(mediaUrl);
      await controller.setLooping(true);
      await controller.initialize();
      await controller.play();
      videoController = controller;
    } else if (_isImageAsset(mediaUrl)) {
      imagePath = mediaUrl;
    }

    return const Result.success(null);
  }

  @override
  void dispose() {
    // No need to wait for disposal to complete.
    // ignore: discarded_futures
    videoController?.dispose();
    super.dispose();
  }
}
