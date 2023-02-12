import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/crypto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final formatCurrency = NumberFormat.simpleCurrency();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Crypto bitcoin = Provider.of<CryptoViewModel>(context, listen: false)
        .cryptoList
        .firstWhere((element) => element.id == "bitcoin");
    Crypto ether = Provider.of<CryptoViewModel>(context, listen: false)
        .cryptoList
        .firstWhere((element) => element.id == "ethereum");
    Crypto bnb = Provider.of<CryptoViewModel>(context, listen: false)
        .cryptoList
        .firstWhere((element) => element.id == "binancecoin");
    Crypto sol = Provider.of<CryptoViewModel>(context, listen: false)
        .cryptoList
        .firstWhere((element) => element.id == "solana");
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
              appBar: null,
              bottomNavigationBar: null,
              backgroundColor: const Color(0XFF1B2540),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.08,
                            right: MediaQuery.of(context).size.width * 0.08,
                            top: MediaQuery.of(context).size.height * 0.025),
                        child: Row(
                          children: [
                            /**
                           * Greetings
                           * */
                            Text(
                              "Good ${greeting()},",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: const Color(0XFF1B2540),
                                child: InkWell(
                                  child: SvgPicture.asset(
                                      "assets/images/search-icon.svg"),
                                  onTap: () {
                                    Navigator.pushNamed(context, searchScreen);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.075,
                          right: MediaQuery.of(context).size.width * 0.075,
                          top: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "BTC / USD",
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0325,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.9),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        double.parse(bitcoin
                                                    .marketCapChangePercentage
                                                    .toString()) >
                                                0
                                            ? "+${bitcoin.marketCapChangePercentage.toString().substring(0, bitcoin.marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                            : "${bitcoin.marketCapChangePercentage.toString().substring(0, bitcoin.marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                        style: GoogleFonts.poppins(
                                            color: double.parse(bitcoin
                                                        .marketCapChangePercentage
                                                        .toString()) <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0275,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "≈ ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0275,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: formatCurrency
                                              .format(bitcoin.currentPrice)
                                              .replaceAll('\$', ""),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.9),
                                        ),
                                        TextSpan(
                                            text: " USD",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9))
                                      ]),
                                ),
                              ],
                            )),
                            const Spacer(),
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "ETH / USD",
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0325,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.9),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        double.parse(ether
                                                    .marketCapChangePercentage
                                                    .toString()) >
                                                0
                                            ? "+${ether.marketCapChangePercentage.toString().substring(0, ether.marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                            : "${ether.marketCapChangePercentage.toString().substring(0, ether.marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                        style: GoogleFonts.poppins(
                                            color: double.parse(ether
                                                        .marketCapChangePercentage
                                                        .toString()) <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0275,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "≈ ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0275,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: formatCurrency
                                              .format(ether.currentPrice)
                                              .replaceAll('\$', ""),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.9),
                                        ),
                                        TextSpan(
                                            text: " USD",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9))
                                      ]),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.075,
                          right: MediaQuery.of(context).size.width * 0.075,
                          top: MediaQuery.of(context).size.height * 0.035,
                          bottom: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "BNB / USD",
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0325,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.9),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        double.parse(bnb
                                                    .marketCapChangePercentage
                                                    .toString()) >
                                                0
                                            ? "+${bnb.marketCapChangePercentage.toString().substring(0, bnb.marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                            : "${bnb.marketCapChangePercentage.toString().substring(0, bnb.marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                        style: GoogleFonts.poppins(
                                            color: double.parse(bnb
                                                        .marketCapChangePercentage
                                                        .toString()) <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0275,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "≈ ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0275,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: formatCurrency
                                              .format(bnb.currentPrice)
                                              .replaceAll('\$', ""),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.9),
                                        ),
                                        TextSpan(
                                            text: " USD",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9))
                                      ]),
                                ),
                              ],
                            )),
                            const Spacer(),
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "SOL / USD",
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0325,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.9),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        double.parse(sol
                                                    .marketCapChangePercentage
                                                    .toString()) >
                                                0
                                            ? "+${sol.marketCapChangePercentage.toString().substring(0, sol.marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                            : "${sol.marketCapChangePercentage.toString().substring(0, sol.marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                        style: GoogleFonts.poppins(
                                            color: double.parse(sol
                                                        .marketCapChangePercentage
                                                        .toString()) <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0275,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "≈ ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0275,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: formatCurrency
                                              .format(sol.currentPrice)
                                              .replaceAll('\$', ""),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.9),
                                        ),
                                        TextSpan(
                                            text: " USD",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9))
                                      ]),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.84,
                          color: const Color(0XFF273958),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.025,
                                right:
                                    MediaQuery.of(context).size.width * 0.025),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  "Trend coins",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.0375,
                                      color: Colors.white,
                                      letterSpacing: 1.3),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: Provider.of<CryptoViewModel>(
                                            context,
                                            listen: false)
                                        .trendCryptoList
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015),
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                Provider.of<CryptoViewModel>(
                                                        context,
                                                        listen: false)
                                                    .trendCryptoList[index]
                                                    .image
                                                    .toString(),
                                              ),
                                              backgroundColor:
                                                  const Color(0XFF273958),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    Provider.of<CryptoViewModel>(
                                                            context,
                                                            listen: false)
                                                        .trendCryptoList[index]
                                                        .symbol
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 0.9,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Colors.white)),
                                                Text(
                                                    "Rank #${Provider.of<CryptoViewModel>(context, listen: false).trendCryptoList[index].marketCapRank}",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0.9,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
