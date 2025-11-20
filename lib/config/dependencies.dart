import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/repositories/exercise/exercise_repository_local.dart';
import 'package:leeft/data/services/local_data_service.dart';

/// The providers for local data.
final providersLocal = <SingleChildWidget>[
  // Expose services so they can immediately be injected into repositories via
  // the [BuildContext.read] method from [provider].
  Provider(create: (_) => LocalDataService()),
  // Expose repositories so they can be injected into view models as needed.
  Provider(
    // Create provider immediately to allow prefetching.
    lazy: false,
    create: (context) =>
        ExerciseRepositoryLocal(localDataService: context.read())
            as ExerciseRepository,
  ),
];
