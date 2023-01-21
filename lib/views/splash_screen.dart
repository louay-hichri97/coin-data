import 'package:coin_data/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
        navigateRoute: const OnBoardingScreen(),
        duration: 3000,
        backgroundColor: Colors.black,
    );
  }
}
