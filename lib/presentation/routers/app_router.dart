import 'package:flutter/material.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String home = "homeScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _home();
      default:
        throw Exception("Route was not Found");
    }
  }

  static _home() {
    return MaterialPageRoute(
        builder: (context) => const HomeScreen());
  }
}
