import 'package:flutter/material.dart';
import 'package:qubic_ai/router/app_router.dart';
import 'package:qubic_ai/utils/constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/utils/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        builder: (context, widget) {
          final mediaQueryData = MediaQuery.of(context);
          final scaledMediaQueryData = mediaQueryData.copyWith(
            textScaler: TextScaler.noScaling,
          );
          return MediaQuery(
            data: scaledMediaQueryData,
            child: widget!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Qubix AI',
        initialRoute: RouteManager.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: AppTheme.darkTheme,
      ),
    );
  }
}
