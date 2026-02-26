import 'package:leeft/data/repositories/exercise/exercise_development_repository.dart';
import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/repositories/routine/routine_development_repository.dart';
import 'package:leeft/data/repositories/routine/routine_repository.dart';
import 'package:leeft/data/services/asset_bundle_service.dart';
import 'package:leeft/data/services/database_service.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// The providers exposing services and repositories used during development.
final List<SingleChildWidget> developmentProviders = [
  Provider(create: (_) => AssetBundleService()),
  Provider(create: (_) => DatabaseService()),
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
];
