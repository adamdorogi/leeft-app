import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';

import 'package:leeft/config/assets.dart';
import 'package:leeft/domain/models/exercise/exercise.dart';

/// A stateless service for retrieving assets from the asset bundle.
class LocalDataService {
  /// The exercises from the exercise file.
  AsyncResult<List<Exercise>> get exercises async {
    try {
      final localData = await rootBundle.loadString(Assets.exercises);
      final json = List<Map<String, dynamic>>.from(jsonDecode(localData));
      final exercises = json.map(Exercise.fromJson).toList();
      return Success(exercises);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }
}
