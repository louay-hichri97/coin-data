import 'package:coin_data/views/converter_screen.dart';
import 'package:coin_data/views/exchanges_screen.dart';
import 'package:coin_data/views/home_screen.dart';
import 'package:coin_data/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
        body: currentIndex == 0
            ? const HomeScreen()
            : (currentIndex == 1
                ? const ExchangesScreen()
                : (currentIndex == 2
                    ? const SearchScreen()
                    : const ConverterScreen())),
      )),
    );
  }
}
