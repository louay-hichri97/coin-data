import 'package:coin_data/models/crypto.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:coin_data/utils/constants.dart';
import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _apiService = ApiService();
  List _cryptoList = [];
  List _filterList = [];
  fetchCrypto() async {
    try {
      var result = await _apiService.getCryptoListData();
      setState(() {
        _cryptoList = result;
      });

    } catch(e) {
      print(e);
    }
  }

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0XFF1B2540),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.065,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,

                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.pushNamed(context, homeScreen);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: const Color(0XFF1B2540),
                      child: SvgPicture.asset(
                          "assets/images/icon-back.svg"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
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
                        color:Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search token ...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.015
                        ),
                        child: SvgPicture.asset(
                          "assets/images/search-icon.svg"
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color:Colors.white
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
                      fillColor: const Color(0XFF273958),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              if(_searchController.text.isNotEmpty && _filterList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                          itemCount: _filterList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print(index);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.015,
                                  bottom: MediaQuery.of(context).size.height * 0.015,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage(_filterList[index].image.toString()))
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                                    Text(
                                        _filterList[index].name.toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.0325,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.9),
                                    ),


                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),

              if(_searchController.text.isNotEmpty && _filterList.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * 0.075,),
                      Image.asset("assets/images/error-404.png", color: Colors.white, width: MediaQuery.of(context).size.width * 0.3,),


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
                              color: Colors.white,
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
    );
  }
}
