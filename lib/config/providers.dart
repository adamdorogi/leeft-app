import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:relift/data/repositories/exercise/exercise_development_repository.dart';
import 'package:relift/data/repositories/exercise/exercise_repository.dart';
import 'package:relift/data/repositories/routine/routine_development_repository.dart';
import 'package:relift/data/repositories/routine/routine_repository.dart';
import 'package:relift/data/repositories/theme/theme_development_repository.dart';
import 'package:relift/data/repositories/theme/theme_repository.dart';
import 'package:relift/data/services/asset_bundle_service.dart';
import 'package:relift/data/services/database_service.dart';
import 'package:relift/data/services/shared_preferences_service.dart';

/// The providers exposing services and repositories used during development.
final List<SingleChildWidget> developmentProviders = [
  Provider(create: (_) => AssetBundleService()),
  Provider(create: (_) => DatabaseService()),
  Provider(create: (_) => SharedPreferencesService()),
  Provider(
    create: (context) =>
        ExerciseDevelopmentRepository(assetBundleService: context.read())
            as ExerciseRepository,
  ),
  Provider(
    create: (context) =>
        RoutineDevelopmentRepository(databaseService: context.read())
            as RoutineRepository,
  ),
  Provider(
    create: (context) =>
        ThemeDevelopmentRepository(sharedPreferencesService: context.read())
            as ThemeRepository,
  ),
];
