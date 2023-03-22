import 'package:coin_data/views_models/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/crypto.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _convertercontroller = TextEditingController();
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  Crypto? _selectedCrypto;
  String result = "";
  @override
  void initState() {
    super.initState();
    _convertercontroller.text = "1";
    _selectedCrypto = Provider.of<CryptoViewModel>(context, listen: false)
        .cryptoList
        .getRange(0, 9)
        .first;
    result = (double.parse(_selectedCrypto?.currentPrice.toString() ?? "0") *
            double.parse(_convertercontroller.text))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.035,
                      bottom: MediaQuery.of(context).size.height * 0.035),
                  child: Text("Cryptocurrency Converter Calculator",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).size.height * 0.018)),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,8}'))
                    ],
                    controller: _convertercontroller,
                    onChanged: (value) {
                      setState(() {
                        _convertercontroller.text = value;
                        _convertercontroller.selection =
                            TextSelection.collapsed(
                                offset: _convertercontroller.text.length);
                        result = (double.parse(
                                    _selectedCrypto?.currentPrice.toString() ??
                                        "0") *
                                double.parse(_convertercontroller.text))
                            .toString();
                      });
                    },
                    style: GoogleFonts.poppins(
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: Colors.black),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.035)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.035),
                        borderSide: const BorderSide(
                          color: Colors.grey,
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
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.035)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.035),
                        borderSide: const BorderSide(
                          color: Colors.grey,
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
                    value: _selectedCrypto?.name,
                    items: Provider.of<CryptoViewModel>(context, listen: false)
                        .cryptoList
                        .getRange(0, 9)
                        .map((Crypto crypto) {
                      return DropdownMenuItem(
                          value: crypto.name,
                          child: Text(
                            "${crypto.name.toString().length > 5 ? "${crypto.name.toString().substring(0, 4)}..." : crypto.name} ( ${crypto.symbol.toString().toUpperCase()} )",
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.0125),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCrypto =
                            Provider.of<CryptoViewModel>(context, listen: false)
                                .cryptoList
                                .getRange(0, 9)
                                .firstWhere((element) =>
                                    element.name.toString().toLowerCase() ==
                                    value.toString().toLowerCase());
                        result = (double.parse(
                                    _selectedCrypto?.currentPrice.toString() ??
                                        "0") *
                                double.parse(_convertercontroller.text))
                            .toString();
                      });
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  "assets/images/convertisseur.svg",
                  height: MediaQuery.of(context).size.height * 0.03,
                  color: const Color(0xFF210080),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text("United States Dollar ( USD )",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height * 0.015)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(_convertercontroller.text,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.015)),
                        Text(_selectedCrypto?.name ?? "",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015))
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(" = ",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      children: [
                        Text(
                            formatCurrency
                                .format(double.parse(result))
                                .toString()
                                .replaceAll('\$', ""),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.015)),
                        Text("USD",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
