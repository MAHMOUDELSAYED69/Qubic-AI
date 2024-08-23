import 'package:flutter/material.dart';
import 'package:qubic_ai/view/screens/home.dart';

import '../utils/constants/routes.dart';
import '../view/screens/splash.dart';
import 'page_transition.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RouteManager.home:
        return PageTransitionManager.slideTransition(const HomeScreen());
     
      default:
        return null;
    }
  }
}
