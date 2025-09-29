import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:leeft/data/repositories/exercise/exercise_repository.dart';
import 'package:leeft/data/repositories/exercise/exercise_repository_local.dart';
import 'package:leeft/data/services/local_data_service.dart';
import 'package:leeft/l10n/app_localizations.dart';
import 'package:leeft/routing/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => LocalDataService()),
        Provider(
          create: (context) =>
              ExerciseRepositoryLocal(localDataService: context.read())
                  as ExerciseRepository,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData.dark(),
    );
  }
}
