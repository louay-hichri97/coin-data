import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../views_models/crypto_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ExchangesScreen extends StatefulWidget {
  const ExchangesScreen({Key? key}) : super(key: key);

  @override
  _ExchangesScreenState createState() => _ExchangesScreenState();
}



class _ExchangesScreenState extends State<ExchangesScreen> {
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.035,
                        bottom: MediaQuery.of(context).size.height * 0.035
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
                      itemCount: Provider.of<CryptoViewModel>(context, listen: false).exchangesList.length,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
