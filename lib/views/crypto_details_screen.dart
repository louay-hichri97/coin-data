import 'package:flutter/material.dart';


class CryptoDetailsScreen extends StatefulWidget {
  const CryptoDetailsScreen({Key? key}) : super(key: key);

  @override
  _CryptoDetailsScreenState createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1B2540),
      body: Text(
        "Crypto details screen"
      ),
    );
  }
}
