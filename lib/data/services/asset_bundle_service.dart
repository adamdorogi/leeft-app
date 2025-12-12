import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:leeft/config/assets.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/result.dart';

/// A stateless service for retrieving assets from the asset bundle.
class AssetBundleService {
  /// The exercises from the exercises asset.
  Future<Result<List<Exercise>>> loadExercises() async {
    try {
      final exercisesString = await rootBundle.loadString(Assets.exercises);
      final exerciseMaps = List<Map<String, dynamic>>.from(
        jsonDecode(exercisesString) as List<dynamic>,
      );
      final exercises = exerciseMaps.map(Exercise.fromJson).toList();
      return Result.success(exercises);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
