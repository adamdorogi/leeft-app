import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

/// A stateless service for retrieving assets from remote URLs.
class RemoteDataService {
  /// The binary data from the [url].
  AsyncResult<Uint8List> bytesAt(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return Success(response.bodyBytes);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e));
    }
  }
}
