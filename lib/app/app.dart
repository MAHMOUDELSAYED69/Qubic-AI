import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubic_ai/app/router/app_router.dart';
import 'package:qubic_ai/core/utils/constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/app/themes/app_theme.dart';

import '../core/di/get_it.dart';
import '../presentation/viewmodel/chat/chat_bloc.dart';
import '../presentation/viewmodel/validation/validation_cubit.dart';

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
            create: (context) => getIt<ChatAIBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ValidationCubit>(),
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
          title: 'Qubic AI',
          initialRoute: RouteManager.initialRoute,
          onGenerateRoute: AppRouter.onGenerateRoute,
          theme: AppTheme.darkTheme,
        ),
      ),
    );
  }
}
