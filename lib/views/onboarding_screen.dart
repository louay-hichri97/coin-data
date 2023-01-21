import 'package:coin_data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(

            body: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/onboarding-background.png",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.25,
                    left: size.width * 0.1,
                    right: size.width * 0.1
                  ),
                  child: Center(
                    child: Text(
                      "Free crypto investing from your phone",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: size.height * 0.035,
                        height: 0.9
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.5,
                    left: size.width * 0.1,
                    right: size.width * 0.1
                  ),
                  child: Center(
                    child: Text(
                      "Invest in all of the most popular cryptos straight from your phone. Best of all - it’s 100% free! ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        height: 1,
                        fontSize: size.height * 0.02,
                        letterSpacing: 0.75,

                      ),
                    ),
                  ),
                ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.75
              ),
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          0.0,
                          0.4,
                          0.6,
                          0.9,
                          0.1
                        ],
                        colors: [
                          const Color(0XFF18B2EA).withOpacity(0.7),
                          const Color(0XFFDB004F).withOpacity(0.7),
                          const Color(0XFFDB004F).withOpacity(0.7),
                          const Color(0XFFDB004F).withOpacity(0.7),
                          const Color(0XFFDB004F).withOpacity(0.7),
                        ],
                      ),
                      color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.transparent),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size.width *
                                          0.03)))),

                      onPressed: () {
                        Navigator.pushNamed(context, homeScreen);
                      },
                      child: Text(
                        "Let's go",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontStyle: FontStyle.normal,
                          fontSize: size.height * 0.018
                        ),
                        ),
                      )
                  ),
                ),
            ),

              ],
            ),
          )
      ),
    );
  }
}
