import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:leeft/config/providers.dart';
import 'package:leeft/ui/app/app.dart';

import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = .ALL;
  Logger.root.onRecord.listen((logRecord) {
    if (kDebugMode) {
      print(logRecord);
    }
  });

  runApp(
    // Inject dependencies (providers) into the top level of the applciation.
    MultiProvider(providers: developmentProviders, child: const App()),
  );
}
