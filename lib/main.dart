import 'package:coin_data/router/router.dart';
import 'package:coin_data/views/onboarding_screen.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views/splash_screen.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_) => CryptoViewModel())
     ],
      child:const  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'coinData',
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: splashScreen,
      ),
    );
  }
}
