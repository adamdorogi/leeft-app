import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/command.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A view model for managing the UI state of the exercise details screen.
class ExerciseDetailsViewModel {
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

  /// Whether the media asset at [mediaUrl] is a video.
  bool isVideo(String mediaUrl) => mediaUrl.split('.').last == 'mp4';

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
}
