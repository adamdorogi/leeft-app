import 'package:leeft/data/repositories/exercise/exercise_development_repository.dart';
import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/services/asset_bundle_service.dart';
import 'package:leeft/data/services/remote_data_service.dart';
import 'package:leeft/utils/result.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// The providers exposing services and repositories used during development.
final List<SingleChildWidget> developmentProviders = [
  Provider(create: (_) => AssetBundleService()),
  Provider(create: (_) => RemoteDataService()),
  Provider(
    // Create provider immediately to allow prefetching.
    lazy: false,
    create: (context) {
      final repo =
          ExerciseDevelopmentRepository(
                assetBundleService: context.read(),
                remoteDataService: context.read(),
              )
              as ExerciseRepository;

      // Prefetch exercise and image data from repo.
      // ignore: discarded_futures
      (() async {
        final exercisesResult = await repo.exercises;
        switch (exercisesResult) {
          case Success(value: final exercises):
            for (final exercise in exercises) {
              // Don't need the result, just prefetching.
              // ignore: unawaited_futures
              repo.thumbnailBytesFor(exercise.id);
            }
          case Failure():
        }
      })();

      return repo;
    },
  ),
];
