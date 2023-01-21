import 'package:coin_data/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


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
    _filterList = [];
    for(var i = 0; i< _cryptoList.length ; i ++) {
      if(_cryptoList[i]["name"].toString().trim().contains(name.trim())) {
        _filterList.add(_cryptoList[i]);
      }
    }
    print(_filterList);
  }


  @override
  void initState() {
    super.initState();
    fetchCrypto();
    filter("btc");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1B2540),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.08,
          right: MediaQuery.of(context).size.width * 0.08
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.065,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
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

            /*if(_searchController.text.isNotEmpty)
              ListView.builder(
                  itemCount: _cryptoList.length,
                  itemBuilder: (context, index) {
                    List _filterCryptoList
                  }
              )*/

          ],
        ),
      ),
    );
  }
}
