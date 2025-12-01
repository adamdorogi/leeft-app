import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leeft/config/providers.dart';
import 'package:leeft/ui/app/app.dart';

void main() {
  runApp(
    // Use dependency injection to expose services and repositories as
    // [Provider] objects to the top level of the widget tree of [MainApp].
    MultiProvider(providers: providersLocal, child: const App()),
  );
}
