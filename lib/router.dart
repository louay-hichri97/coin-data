import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views/home_screen.dart';
import 'package:coin_data/views/onboarding_screen.dart';
import 'package:coin_data/views/search_screen.dart';
import 'package:coin_data/views/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text(
              "No page found with this ${settings.name} route"
            ),
          ),
        ));
    }
    
  }
}