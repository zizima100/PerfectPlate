import 'package:flutter/material.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_page.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:perfectplate/presentation/screens/auth/auth_page.dart';
import 'package:perfectplate/presentation/screens/home_or_auth/home_or_auth_page.dart';

class PerfectPlateRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const PlatesHomePage(),
        );
      case Routes.homeOrAuth:
        return MaterialPageRoute(
          builder: (_) => const HomeOrAuth(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
