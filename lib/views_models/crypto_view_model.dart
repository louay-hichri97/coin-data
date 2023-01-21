import 'package:coin_data/models/crypto.dart';
import 'package:coin_data/service/api_service.dart';
import 'package:flutter/material.dart';


class CryptoViewModel extends ChangeNotifier {
  // PRIVATE
  List<Crypto> _cryptoList = [];
  List<Crypto> _trendCryptoList = [];
  final ApiService _apiService = ApiService();


  List<Crypto> get cryptoList => _cryptoList;
  List<Crypto> get trendCryptoList => _trendCryptoList;

  // FETCH ALL COINS
  Future<List<Crypto>> fetchCryptoList() async {
    try {
      var result = await _apiService.getCryptoListData();
      _cryptoList = result.map<Crypto>((e) => Crypto.fromJson(e)).toList();
      return _cryptoList;
    } catch(e) {
      throw Exception('Unable to fetch data from the RestAPI');
    }


  }

  // FETCH TREND COINS
  Future<List<Crypto>> fetchCryptoTrendList() async {
    try {
      var result = await _apiService.getTrendCrypto();
      _trendCryptoList = result["coins"].map<Crypto>((e) => Crypto.fromJsonTrend(e)).toList();
      return _trendCryptoList;
    } catch(e) {
      throw Exception('Unable to fetch data from the RestAPI');
    }

  }
}