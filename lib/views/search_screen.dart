import 'package:coin_data/models/crypto.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _apiService = ApiService();
  final controller = ScrollController(initialScrollOffset: 50.0);
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  List _cryptoList = [];
  List _filterList = [];


  filter(String name) {
    setState(() {
      _filterList = [];
    });
    for(var i = 0; i < Provider.of<CryptoViewModel>(context, listen: false).cryptoList.length ; i ++) {
      if(Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i].id.toString().trim().contains(name.trim()) || Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i].symbol.toString().trim().contains(name.trim())) {
        setState(() {
          _filterList.add(Provider.of<CryptoViewModel>(context, listen: false).cryptoList[i]);
        });

      }
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        if(value.isNotEmpty) {
                          filter(value);
                        } else {
                          setState(() {
                            _filterList = [];
                          });
                        }


                      },
                      style: GoogleFonts.poppins(
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color:Colors.black
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search token ...',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.015
                          ),
                          child: SvgPicture.asset(
                            "assets/images/search-icon.svg",
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: GoogleFonts.poppins(
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color:Colors.black
                        ),
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(context).size.width * 0.035)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.035),
                          borderSide:  const BorderSide(
                            color:  Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.035),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                if(_searchController.text.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: ListView.builder(
                        itemCount: Provider.of<CryptoViewModel>(context,
                            listen: false)
                            .cryptoList.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto = Provider.of<CryptoViewModel>(context, listen: false).cryptoList[index];
                              Navigator.pushNamed(context, cryptoDetails);
                            },
                            child: Padding(
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
                            ),
                          );
                        }),
                  ),


                if(_searchController.text.isNotEmpty && _filterList.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: ListView.builder(
                        itemCount: _filterList.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<CryptoViewModel>(context, listen: false).selectedCrypto = _filterList[index];
                              Navigator.pushNamed(context, cryptoDetails);
                            },
                            child: Padding(
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
                                        _filterList[index]
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
                                            _filterList[index]
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
                                            _filterList[index]
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
                                            _filterList[index]
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
                                      double.parse(_filterList[index]
                                          .marketCapChangePercentage
                                          .toString()) >
                                          0
                                          ? "+${_filterList[index].marketCapChangePercentage.toString().substring(0, _filterList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %"
                                          : "${_filterList[index].marketCapChangePercentage.toString().substring(0, _filterList[index].marketCapChangePercentage.toString().indexOf('.') + 3)} %",
                                      style: GoogleFonts.poppins(
                                          color: double.parse(_filterList[index]
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
                                      _filterList[index]
                                          .marketCapRank ==
                                          null
                                          ? "Rank # --"
                                          : "Rank #${_filterList[index].marketCapRank}",
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
                          );
                        }),
                  ),

                if(_searchController.text.isNotEmpty && _filterList.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height * 0.075,),
                        Image.asset("assets/images/error-404.png", color: Colors.black, width: MediaQuery.of(context).size.width * 0.3,),


                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15,
                            top: MediaQuery.of(context).size.height * 0.075,
                          ),
                          child: Text(
                              "Opssss ... No crypto match with this name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.0325,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.9),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
