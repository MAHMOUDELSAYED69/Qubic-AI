import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qubic_ai/core/di/get_it.dart';

import 'app/app.dart';
import 'core/services/database/hivedb.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await HiveDb().initializeDatabase();
  await dotenv.load(fileName: '.env');

  getItSetup();

  runApp(const MyApp());
}
