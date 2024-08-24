import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'services/database/hivedb.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await HiveDb().initializeDatabase();
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}
