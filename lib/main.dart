import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/core/data/datasources/database.dart';
import 'package:time_tracker/src/tracker/data/datasources/tracker_local_datasource.dart';
import 'package:time_tracker/src/tracker/data/repository/tracker_repository_impl.dart';
import 'package:time_tracker/src/tracker/domain/repository/tracker_repository.dart';
import 'package:time_tracker/src/tracker/presentation/controller/tracker_controller.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => settingsController),
        ChangeNotifierProvider(
          create: (context) => TrackerController(
            trackerRepository: TrackerRepositoryImpl(
              localDatasource: TrackerLocalDatasource(
                databaseProvider: AppDatabase(),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (context) => settingsController),
      ],
      child: const MyApp(),
    ),
  );
}
