import 'package:approvelt/features/auth/screens/auth_checker_screen.dart';
import 'package:approvelt/features/auth/screens/login_screen.dart';
import 'package:approvelt/features/auth/screens/register_screen.dart';
import 'package:approvelt/features/home/screens/add_request_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterScreen(),
      );

    case AuthChecker.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthChecker(),
      );

    case AddEventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddEventScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
