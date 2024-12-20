import 'package:CarTracker/screens/onboarding/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

class ScreenRouteList {
  static Map<String, Widget Function(BuildContext)> screenRoutes = {
    '/': (context) => const SplashScreen(),
  };
}
