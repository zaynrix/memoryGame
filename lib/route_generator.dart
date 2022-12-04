import 'package:flutter/material.dart';
import 'package:muslim/homepage.dart';
import 'package:muslim/src/pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      // case '/Home':
      //   return MaterialPageRoute(builder: (_) => Home());
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => HomePage());

      // case 'debug':
      //   return MaterialPageRoute(builder: (_) => NewDebug());

      default:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
    }
  }
}
