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
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);

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
    print(Provider.of<CryptoViewModel>(context, listen: false)
            .trendCryptoList[7]
            .marketCapRank ==
        null);
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
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Text(
                  "coinData",
                  style: TextStyle(
                      fontFamily: 'Climate',
                      color: const Color(0xFF210080),
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.w400),
                ),
              ),
              bottomNavigationBar: null,
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.075,
                          right: MediaQuery.of(context).size.width * 0.075,
                          top: MediaQuery.of(context).size.height * 0.015,
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
                                          color: Colors.black,
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
                                              color: Colors.black,
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
                                          color: Colors.black,
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
                                              color: Colors.black,
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
                          bottom: MediaQuery.of(context).size.height * 0.025,
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
                                          color: Colors.black,
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
                                              color: Colors.black,
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
                                          color: Colors.black,
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
                                              color: Colors.black,
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
                            left: MediaQuery.of(context).size.width * 0.05,
                            bottom: MediaQuery.of(context).size.height * 0.025
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/fire.svg",
                              color: const Color(0XFFCD0404),
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.035,
                            ),
                            Text("Trending",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0225)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.01),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.5),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: Provider.of<CryptoViewModel>(context,
                                    listen: false)
                                .trendCryptoList
                                .length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      Provider.of<CryptoViewModel>(context,
                                              listen: false)
                                          .trendCryptoList[index]
                                          .image
                                          .toString(),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.02
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,

                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            Provider.of<CryptoViewModel>(context,
                                                    listen: false)
                                                .trendCryptoList[index]
                                                .symbol
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                                color: Colors.black)),
                                        Text(
                                            Provider.of<CryptoViewModel>(context,
                                                            listen: false)
                                                        .trendCryptoList[index]
                                                        .marketCapRank ==
                                                    null
                                                ? "Rank # --"
                                                : "Rank #${Provider.of<CryptoViewModel>(context, listen: false).trendCryptoList[index].marketCapRank}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.9,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              ),
                          child: Text(
                              "Today's Cryptocurrency Prices by Market Cap",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: ListView.builder(
                            itemCount: 10,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0
                                      ? MediaQuery.of(context).size.height *
                                          0.03
                                      : MediaQuery.of(context).size.height *
                                          0.015,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.075,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          Provider.of<CryptoViewModel>(context,
                                                  listen: false)
                                              .cryptoList[index]
                                              .image
                                              .toString(),
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.125,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              Provider.of<CryptoViewModel>(
                                                      context,
                                                      listen: false)
                                                  .cryptoList[index]
                                                  .name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  color: Colors.black)),
                                          Text(
                                              Provider.of<CryptoViewModel>(
                                                      context,
                                                      listen: false)
                                                  .cryptoList[index]
                                                  .symbol
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.9,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: Text(
                                          formatCurrency.format(
                                              Provider.of<CryptoViewModel>(
                                                      context,
                                                      listen: false)
                                                  .cryptoList[index]
                                                  ?.currentPrice),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.9,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012,
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        double.parse(Provider.of<CryptoViewModel>(
                                                        context,
                                                        listen: false)
                                                    .cryptoList[index]
                                                    .marketCapChangePercentage
                                                    .toString()) >
                                                0
                                            ? "+${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().substring(0, Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                            : "${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().substring(0, Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                        style: GoogleFonts.poppins(
                                            color: double.parse(Provider.of<
                                                                CryptoViewModel>(
                                                            context,
                                                            listen: false)
                                                        .cryptoList[index]
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
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                    Text(
                                        Provider.of<CryptoViewModel>(context,
                                                        listen: false)
                                                    .cryptoList[index]
                                                    .marketCapRank ==
                                                null
                                            ? "Rank # --"
                                            : "Rank #${Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index].marketCapRank}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.9,
                                            fontStyle: FontStyle.normal,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            color: Colors.grey)),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, searchScreen);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.015
                          ),
                          child: Text(
                            "Show more Cryptocurrencies ...",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF210080),
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.0135),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                    ],
                  ),
                ),
              ))),
    );
  }
}
