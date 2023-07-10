import 'package:flutter/material.dart';
import 'package:numerical_project/screens/about_us.dart';
import 'package:numerical_project/screens/bisection.dart';
import 'package:numerical_project/screens/calculator_screen.dart';
import 'package:numerical_project/screens/falsi.dart';
import 'package:numerical_project/screens/ieee754.dart';
import 'package:numerical_project/screens/jacobi.dart';
import 'package:numerical_project/screens/newton.dart';
import 'package:numerical_project/screens/preferences.dart';
import 'package:numerical_project/screens/secant.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BisectionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BisectionScreen(),
      );
    case FalsePositionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FalsePositionScreen(),
      );
    case NewtonRaphsonScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NewtonRaphsonScreen(),
      );
    case SecantScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SecantScreen(),
      );
    case JacobiScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const JacobiScreen(),
      );
    case IEEE754Screen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const IEEE754Screen(),
      );
    case CalculatorScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CalculatorScreen(),
      );
    case PreferencesScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PreferencesScreen(),
      );
    case AboutUsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutUsScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
