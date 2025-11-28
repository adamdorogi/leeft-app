import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/repositories/exercise/exercise_repository_local.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/data/services/remote_data_service.dart';

/// The providers for local data.
final providersLocal = <SingleChildWidget>[
  // Expose services so they can immediately be injected into repositories via
  // the [BuildContext.read] method from [provider].
  Provider(create: (_) => LocalDataService()),
  Provider(create: (_) => RemoteDataService()),
  // Expose repositories so they can be injected into view models as needed.
  Provider(
    // Create provider immediately to allow prefetching.
    lazy: false,
    create: (context) {
      final repo =
          ExerciseRepositoryLocal(
                localDataService: context.read(),
                remoteDataService: context.read(),
              )
              as ExerciseRepository;

      // Prefetch exercise and image data from repo.
      // ignore: discarded_futures
      (() async {
        final exercisesResult = await repo.exercises;
        if (exercisesResult.isSuccess()) {
          final exercises = exercisesResult.getOrNull()!;
          for (final exercise in exercises) {
            // ignore: unawaited_futures
            repo.thumbnailFor(exercise.id);
          }
        }
      })();

      return repo;
    },
  ),
];
