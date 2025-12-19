import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:leeft/utils/result.dart';

import 'package:logging/logging.dart';

/// A stateless service for retrieving data from remote URLs.
class RemoteDataService {
  final _log = Logger((RemoteDataService).toString());

  /// The binary data at the [url].
  Future<Result<Uint8List>> downloadBytesFrom(String url) async {
    _log.info('Downloading image from $url...');
    try {
      final response = await http.get(Uri.parse(url));
      _log.info('Successfully downloaded image from $url.');
      return Result.success(response.bodyBytes);
    } on Exception catch (e) {
      _log.warning('Failed to download image from $url: $e');
      return Result.failure(e);
    }
  }
}
