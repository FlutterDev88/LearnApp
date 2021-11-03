import 'package:flutter/material.dart';
import 'package:learn_app/configs/routes/app_routes_constants.dart';
import 'package:learn_app/views/main_screen.dart';
import 'package:learn_app/views/save_screen.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case kMainScreen:
        return MaterialPageRoute(
            builder: (_) => const MainScreen()
        );
      case kSaveScreen:
        return MaterialPageRoute(
            builder: (_) => SaveScreen(onFinish: args['onFinish'])
        );
      default:
        return MaterialPageRoute(
            builder: (_) => const MainScreen()
        );
    }
  }
}