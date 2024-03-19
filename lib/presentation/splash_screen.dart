import 'package:activity/activity.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_valuechain/presentation/task_activity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 5000,
        splash: Image.asset("assets/images/logo.png"),
        // nextScreen: TaskActivity(),
        nextScreen: TaskActivity(),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
      ),
    );
  }
}
