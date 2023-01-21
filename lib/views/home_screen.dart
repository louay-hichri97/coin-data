import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    _apiService.getCryptoListData().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
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
                      top: MediaQuery.of(context).size.height * 0.025
                    ),
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
                            fontSize: MediaQuery.of(context).size.width * 0.04
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: const Color(0XFF1B2540),
                            child: InkWell(
                              child: SvgPicture.asset(
                                "assets/images/search-icon.svg"
                              ),
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
                      left: MediaQuery.of(context).size.width * 0.08,
                      top: MediaQuery.of(context).size.height * 0.075,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: Row(
                      children: [
                        FutureBuilder(
                            future: _apiService.getCryptoData("bitcoin"),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "BTC / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                snapshot.data["market_data"]["market_cap_change_percentage_24h"] > 0 ? "+${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3 )}%" : "${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3)}%",
                                                style: GoogleFonts.poppins(
                                                    color: snapshot.data["market_data"]["market_cap_change_percentage_24h"] < 0 ? Colors.red : Colors.green,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: formatCurrency.format(snapshot.data["market_data"]["current_price"]["usd"]).replaceAll('\$', ""),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              } else {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "BTC / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                "--%",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: "--",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              }
                            }
                        ),
                        const Spacer(),
                        FutureBuilder(
                            future: _apiService.getCryptoData("ethereum"),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "ETH / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                snapshot.data["market_data"]["market_cap_change_percentage_24h"] > 0 ? "+${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3 )}%" : "${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3)}%",
                                                style: GoogleFonts.poppins(
                                                    color: snapshot.data["market_data"]["market_cap_change_percentage_24h"] < 0 ? Colors.red : Colors.green,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: formatCurrency.format(snapshot.data["market_data"]["current_price"]["usd"]).replaceAll('\$', ""),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              } else {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "ETH / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                "--%",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: "--",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              }
                            }
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08,
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: Row(
                      children: [
                        FutureBuilder(
                            future: _apiService.getCryptoData("binancecoin"),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "BNB / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                snapshot.data["market_data"]["market_cap_change_percentage_24h"] > 0 ? "+${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3 )}%" : "${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3)}%",
                                                style: GoogleFonts.poppins(
                                                    color: snapshot.data["market_data"]["market_cap_change_percentage_24h"] < 0 ? Colors.red : Colors.green,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: formatCurrency.format(snapshot.data["market_data"]["current_price"]["usd"]).replaceAll('\$', ""),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              } else {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "BNB / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                "--%",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: "--",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              }
                            }
                        ),
                        const Spacer(),
                        FutureBuilder(
                            future: _apiService.getCryptoData("solana"),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "SOL / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                snapshot.data["market_data"]["market_cap_change_percentage_24h"] > 0 ? "+${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3 )}%" : "${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3)}%",
                                                style: GoogleFonts.poppins(
                                                    color: snapshot.data["market_data"]["market_cap_change_percentage_24h"] < 0 ? Colors.red : Colors.green,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: formatCurrency.format(snapshot.data["market_data"]["current_price"]["usd"]).replaceAll('\$', ""),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              } else {
                                return SizedBox(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "SOL / USD",
                                              style: GoogleFonts.poppins(
                                                  fontSize: MediaQuery.of(context).size.width * 0.0325,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.9
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.015
                                              ),
                                              child: Text(
                                                "--%",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        RichText(
                                          text: TextSpan(
                                              text: "≈ ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,

                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                  text: "--",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.9
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: " USD",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.9
                                                    )
                                                )
                                              ]
                                          ),

                                        ),
                                      ],
                                    )
                                );
                              }
                            }
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.035,),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.84,
                    color: const Color(0XFF273958),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.025,
                        right: MediaQuery.of(context).size.width * 0.025
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Text(
                            "Trend coins",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: MediaQuery.of(context).size.width * 0.0375,
                              color: Colors.white,
                              letterSpacing: 1.3
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.025,),

                          FutureBuilder(
                              future: _apiService.getTrendCrypto(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshot.data["coins"].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height * 0.015,
                                            bottom: MediaQuery.of(context).size.height * 0.015
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(

                                                backgroundImage: NetworkImage(
                                                  snapshot.data["coins"][index]["item"]["small"],
                                                ),
                                                backgroundColor: const Color(0XFF273958),
                                              ),

                                              SizedBox(width: MediaQuery.of(context).size.width * 0.035,),

                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data["coins"][index]["item"]["symbol"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w700,
                                                      letterSpacing: 0.9,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      color: Colors.white
                                                    )
                                                  ),
                                                  Text(
                                                      "Rank #${snapshot.data["coins"][index]["item"]["market_cap_rank"]}",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w400,
                                                          letterSpacing: 0.9,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: MediaQuery.of(context).size.width * 0.02,
                                                          color: Colors.grey
                                                      )
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              FutureBuilder(
                                                future: _apiService.getCryptoData(snapshot.data["coins"][index]["item"]["id"]),
                                                builder: (context, AsyncSnapshot snapshot) {
                                                  if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {

                                                    return SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.15,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                                text: "≈ ",
                                                                style: GoogleFonts.poppins(
                                                                  color: Colors.grey,

                                                                  fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                children: <TextSpan> [
                                                                  TextSpan(
                                                                    text: formatCurrency.format(snapshot.data["market_data"]["current_price"]["usd"]),
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors.white,
                                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                                        fontWeight: FontWeight.w400,
                                                                        letterSpacing: 0.9
                                                                    ),
                                                                  ),

                                                                ]
                                                            ),

                                                          ),
                                                          Text(
                                                            snapshot.data["market_data"]["market_cap_change_percentage_24h"] > 0 ? "+${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3 )}%" : "${snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().substring(0,snapshot.data["market_data"]["market_cap_change_percentage_24h"].toString().indexOf('.')+3)}%",
                                                            style: GoogleFonts.poppins(
                                                                color: snapshot.data["market_data"]["market_cap_change_percentage_24h"] < 0 ? Colors.red : Colors.green,
                                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                                fontWeight: FontWeight.w700
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.15,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                                text: "≈ ",
                                                                style: GoogleFonts.poppins(
                                                                  color: Colors.grey,

                                                                  fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                children: <TextSpan> [
                                                                  TextSpan(
                                                                    text: "\$--",
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors.white,
                                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                                        fontWeight: FontWeight.w400,
                                                                        letterSpacing: 0.9
                                                                    ),
                                                                  ),

                                                                ]
                                                            ),

                                                          ),
                                                          Text(
                                                          "--%",
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.grey,
                                                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                                                fontWeight: FontWeight.w700
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                },
                                              )

                                            ],
                                          ),
                                        );
                                      }
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.15,
                                      bottom: MediaQuery.of(context).size.height * 0.15
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }
                              }
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
        )
    );
  }
}
