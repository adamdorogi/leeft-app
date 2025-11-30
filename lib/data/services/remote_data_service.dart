import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:leeft/utils/result.dart';

/// A stateless service for retrieving assets from remote URLs.
class RemoteDataService {
  /// The binary data from the [url].
  Future<Result<Uint8List>> bytesAt(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return Result.success(response.bodyBytes);
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e));
    }
  }
}
