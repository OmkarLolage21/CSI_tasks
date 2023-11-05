import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blog_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image(
        image: AssetImage('./assets/images/logo.jpg'),
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .5,
      ),
      backgroundColor: Colors.black,
      nextScreen: HomePage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
