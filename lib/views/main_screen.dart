import 'package:coin_data/views/converter_screen.dart';
import 'package:coin_data/views/exchanges_screen.dart';
import 'package:coin_data/views/home_screen.dart';
import 'package:coin_data/views/search_screen.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/crypto.dart';
import '../service/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiService _apiService = ApiService();
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedFontSize: MediaQuery.of(context).size.height * 0.01,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.01,
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF210080),
          unselectedItemColor: const Color(0xFF210080),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

          },
          selectedLabelStyle: GoogleFonts.poppins(
            color: const Color(0xFF210080),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            color: const Color(0xFF210080),
          ),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/house-fill.svg",
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: const Color(0xFF210080),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/currency-exchange.svg",
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: const Color(0xFF210080),
                ),
                label: 'Exchanges'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/search-icon.svg",
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: const Color(0xFF210080),
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/convertisseur.svg",
                  height: MediaQuery.of(context).size.height * 0.03,
                  color: const Color(0xFF210080),
                ),
                label: 'Converter'),
          ],
        ),
        body:  currentIndex == 0
            ? WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: SafeArea(
              child: Scaffold(
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
                              top: MediaQuery.of(context).size.height * 0.035,
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
                                itemCount: 5,
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
                              setState(() {
                                currentIndex = 2;
                              });
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

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: Text(
                                  "Top Cryptocurrency Spot Exchanges",
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
                                itemCount: 5,
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
                                                  .exchangesList[index]
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
                                          width: MediaQuery.of(context).size.width * 0.15,
                                          child: Text(
                                              Provider.of<CryptoViewModel>(
                                                  context,
                                                  listen: false)
                                                  .exchangesList[index]
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
                                        ),

                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.035,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          child: InkWell(
                                            onTap: () async {
                                              await _launchUrl(Provider.of<CryptoViewModel>(context, listen: false).exchangesList[index].url.toString());
                                            },
                                            child: Text(
                                                Provider.of<CryptoViewModel>(context,
                                                    listen: false)
                                                    .exchangesList[index]
                                                    .url.toString()
                                                ,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.9,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01,
                                                    color: Colors.blue)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.035,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          child: Row(
                                            children: [
                                              Text(
                                                  "#Trust score ",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      color: Colors.grey)
                                              ),
                                              Text(
                                                Provider.of<CryptoViewModel>(context, listen: false).exchangesList[index].trustScore.toString(),
                                                style: GoogleFonts.poppins(
                                                    color: double.parse(Provider.of<CryptoViewModel>(context, listen: false).exchangesList[index].trustScore.toString()) < 8
                                                        ? Colors.red
                                                        : Colors.green,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.0275,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.015,
                                  bottom: MediaQuery.of(context).size.height * 0.015
                              ),
                              child: Text(
                                "Show more Exchanges ...",
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
        )
            : ( currentIndex == 1
                ? const ExchangesScreen()
                : ( currentIndex == 2
                    ? const SearchScreen()
                    : const ConverterScreen())),
      )),
    );
  }
}
