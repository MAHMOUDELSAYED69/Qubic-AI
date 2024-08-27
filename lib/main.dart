import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qubic_ai/core/di/get_it.dart';
import 'package:flutter/services.dart';
import 'package:qubic_ai/core/services/cache/cache.dart';

import 'app/app.dart';
import 'core/services/database/hivedb.dart';
import 'core/utils/constants/colors.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDb().initializeDatabase();
  await SharedPrefsService.sharedPrefInit();
  await dotenv.load(fileName: '.env');
  

  getItSetup();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: ColorManager.black,
      systemNavigationBarIconBrightness: Brightness.dark,
      
    ),
  );
  runApp(const MyApp());
}
