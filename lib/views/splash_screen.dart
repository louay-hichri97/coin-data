import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views/onboarding_screen.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CryptoViewModel _cryptoViewModel = CryptoViewModel();


  fetchCrypto() async {
    try {
      await Provider.of<CryptoViewModel>(context, listen: false).fetchCryptoList();
      await Provider.of<CryptoViewModel>(context, listen: false).fetchCryptoTrendList();
      Navigator.pushNamed(context, onBoardingScreen);
    } catch(e) {

    }
  }

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: const Color(0XFF1B2540),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Center(
              child: Text(
                "coinData",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.035),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
              width: MediaQuery.of(context).size.height * 0.025,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      )),
    );
  }
}
