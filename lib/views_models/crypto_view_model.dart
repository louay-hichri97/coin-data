import 'dart:collection';

import 'package:coin_data/models/crypto.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:flutter/material.dart';

import '../models/Exchange.dart';


class CryptoViewModel with ChangeNotifier {
  // PRIVATE
  List<Crypto> cryptoList = [];
  List<Crypto> trendCryptoList = [];
  List<Exchange> exchangesList = [];
  Crypto? selectedCrypto;
  final ApiService _apiService = ApiService();
  String x = "123";






  // FETCH ALL COINS
   Future fetchCryptoList() async {
    try {
      var result = await _apiService.getCryptoListData();

      var list = result.map<Crypto>((e) => Crypto.fromJson(e)).toList();
      cryptoList.addAll(list);
      return cryptoList;
    } catch(e) {
      throw Exception('Unable to fetch data from the RestAPI');
    }


  }


  // FETCH ALL EXCHANGES
  Future fetchExchangesList() async {
    try {
      var result = await _apiService.getExchangeListData();

      var list = result.map<Exchange>((e) => Exchange.fromJson(e)).toList();
      exchangesList.addAll(list);
      return exchangesList;
    } catch(e) {
      throw Exception('Unable to fetch data from the RestAPI');
    }


  }

  // FETCH TREND COINS
  Future<List<Crypto>> fetchCryptoTrendList() async {
    try {
      var result = await _apiService.getTrendCrypto();
      trendCryptoList = result["coins"].map<Crypto>((e) => Crypto.fromJsonTrend(e)).toList();
      return trendCryptoList;
    } catch(e) {
      throw Exception('Unable to fetch data from the RestAPI');
    }

  }


  selectCrypto(Crypto crypto) {
     selectedCrypto = crypto;
  }
}