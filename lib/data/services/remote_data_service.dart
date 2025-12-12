import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:leeft/utils/result.dart';

/// A stateless service for retrieving data from remote URLs.
class RemoteDataService {
  /// The binary data at the [url].
  Future<Result<Uint8List>> downloadBytesFrom(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return Result.success(response.bodyBytes);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
