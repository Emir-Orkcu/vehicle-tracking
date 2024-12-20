import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Widget>(
      future:  Preferences().authControll(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return AnimatedSplashScreen(
            duration: 500,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white,
            nextScreen: snapshot.data!,
            splash: Image.asset(
              'assets/images/logo_black.png',
              fit: BoxFit.fill,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
