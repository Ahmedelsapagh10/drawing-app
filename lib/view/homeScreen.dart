import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:drawing/view/CanvasView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.white,
        duration: 2000,
        splashIconSize: 250,
        splashTransition: SplashTransition.fadeTransition,
        splash: Lottie.asset('assets/2.json'),
        animationDuration: const Duration(seconds: 2),
        nextScreen: DrawingScreen());
  }
}
