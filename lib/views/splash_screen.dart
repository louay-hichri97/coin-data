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
  bool _errorLoadingData = false;

  fetchCrypto() async {
    try {
      setState(() {
        _errorLoadingData = false;
      });
      await Future.wait([
        Provider.of<CryptoViewModel>(context, listen: false).fetchCryptoList(),
        Provider.of<CryptoViewModel>(context, listen: false).fetchCryptoTrendList(),
        Provider.of<CryptoViewModel>(context, listen: false).fetchExchangesList(),
      ]).then((values) {
        Provider.of<CryptoViewModel>(context, listen: false).selectedIndex = 0;
          Navigator.pushNamed(context, mainScreen);
      }).catchError(
          (err) {
            setState(() {
              _errorLoadingData = true;
            });
          }
      );


    } catch(e) {
      setState(() {
        _errorLoadingData = true;
      });
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
        backgroundColor: Colors.white,
        body: _errorLoadingData
            ? Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Text(
                  "Something went wrong please try again",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(

                      color: const Color(0xFF210080),
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                fetchCrypto();
              },
              child: Text(
                "Retry",
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: const Color(0xFF210080),
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,

            ),
          ],
        )
            : Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Center(
              child: Text(
                "coinData",
                style: TextStyle(
                  fontFamily: 'Climate',
                  color: const Color(0xFF210080),
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
              width: MediaQuery.of(context).size.height * 0.025,
              child: const  CircularProgressIndicator(
                color: Color(0xFF210080),
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
