import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:leeft/config/assets.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';
import 'package:leeft/utils/result.dart';

/// A stateless service for retrieving assets from the asset bundle.
class LocalDataService {
  /// The exercises from the exercise file.
  Future<Result<List<Exercise>>> get exercises async {
    try {
      final localData = await rootBundle.loadString(Assets.exercises);
      final json = List<Map<String, dynamic>>.from(jsonDecode(localData));
      final exercises = json.map(Exercise.fromJson).toList();
      return Result.success(exercises);
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e));
    }
  }
}
