import 'package:flutter/material.dart';
import 'app_routes.dart';

sealed class AppRoutes {
  AppRoutes._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
      //   return MaterialPageRoute(builder: (_) => const SplashPage());
      // case RouteName.CheckCodePage:
      //   return MaterialPageRoute(builder: (_) => const CheckCodePage());
       }
  }
}
