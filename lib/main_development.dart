import 'package:flutter/material.dart';

import 'package:leeft/config/providers.dart';
import 'package:leeft/ui/app/app.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    // Inject dependencies (providers) into the top level of the applciation.
    MultiProvider(providers: developmentProviders, child: const App()),
  );
}
