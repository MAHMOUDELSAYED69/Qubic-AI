import 'package:flutter/material.dart';
import 'package:qubic_ai/features/view/home.dart';
import '../../core/utils/constants/routes.dart';
import '../../features/view/chat.dart';
import '../../features/view/splash.dart';
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
        final sessionId = settings.arguments as List;
        final chatAIBloc = settings.arguments as List;
        return PageTransitionManager.slideTransition(ChatScreen(
          chatAIBloc: chatAIBloc[1],
          chatId: sessionId[0],
          isChatHistory: true,
        ));

      default:
        return null;
    }
  }
}
