import 'package:flutter/material.dart';
import 'package:niteon/views/intro_screens.dart';
import 'package:niteon/views/web.dart';
import 'package:niteon/views/splash_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WebPage.webPage:
        return screenOf(screenName: WebPage());

      case SplashScreen.splashScreen:
        return screenOf(screenName: SplashScreen());

      case IntroScreen.introScreen:
        return screenOf(screenName: IntroScreen());

      default:
        return screenOf(screenName: Container());
    }
  }
}

MaterialPageRoute screenOf({required Widget screenName}) {
  return MaterialPageRoute(builder: (context) => screenName);
}
