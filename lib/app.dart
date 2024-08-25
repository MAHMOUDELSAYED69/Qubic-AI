import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubic_ai/router/app_router.dart';
import 'package:qubic_ai/utils/constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/utils/themes/app_theme.dart';

import 'repositories/message_repository.dart';
import 'services/apis/genetative_ai.dart';
import 'viewmodel/bloc/generativeai_bloc.dart';
import 'viewmodel/validation/formvalidation_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GenerativeAIBloc(
              GenerativeAIWebService(),
              MessageRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ValidationCubit(),
          ),
        ],
        child: MaterialApp(
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
      ),
    );
  }
}
