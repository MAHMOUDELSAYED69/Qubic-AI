import 'package:flutter/material.dart';
import 'package:qubic_ai/view/screens/home.dart';
import '../utils/constants/routes.dart';
import '../view/screens/chat.dart';
import '../view/screens/splash.dart';
import 'page_transition.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RouteManager.home:
        return PageTransitionManager.fadeTransition(const HomeScreen());
      case RouteManager.chat:
        final sessionId = settings.arguments as int;
        return PageTransitionManager.slideTransition(ChatScreen(
          chatId: sessionId,
          isChatHistory: true,
        ));

      default:
        return null;
    }
  }
}
