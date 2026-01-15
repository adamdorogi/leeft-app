import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:leeft/config/assets.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A stateless service for retrieving assets from the asset bundle.
class AssetBundleService {
  final _log = Logger((AssetBundleService).toString());

  /// The exercises from the exercises asset.
  Future<Result<List<Exercise>>> loadExercises() async {
    _log.info('Loading exercises from asset bundle...');
    try {
      final exercisesString = await rootBundle.loadString(Assets.exercises);
      final exerciseMaps = List<Map<String, dynamic>>.from(
        jsonDecode(exercisesString) as List<dynamic>,
      );
      final exercises = exerciseMaps.map(Exercise.fromJson).toList();
      _log.info(
        'Successfully loaded ${exercises.length} exercises from asset bundle.',
      );
      return Result.success(exercises);
    } on Exception catch (e) {
      _log.warning('Failed to load exercises from asset bundle: $e');
      return Result.failure(e);
    }
  }
}
