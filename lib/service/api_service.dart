import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String baseURL = "api.coingecko.com";
  var client = http.Client();


  Future getCryptoListData() async {
    Map<String, String> requestHeaders = {
      "content-type": "application/json; charset=utf-8"
    };
    Map<String, String> queryParameters = {
      "vs_currency": "usd"
    };
    var url = Uri.https(baseURL, "/api/v3/coins/markets", queryParameters);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Unable to fetch data from the RestAPI');
    }
  }

  Future searchCryptoData(String query) async {

    Map<String, String> requestHeaders = {
      "content-type": "application/json; charset=utf-8"
    };
    final queryParameters = {
      "id": query
    };
    var url = Uri.https(baseURL, "/api/v3/search", queryParameters);
    var response = await http.get(url, headers: requestHeaders, );

    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Unable to fetch data from Rest API');
    }

  }
  Future getCryptoData(String id) async {
    Map<String, String> requestHeaders = {
      "content-type": "application/json; charset=utf-8"
    };
    var url = Uri.https(baseURL, "/api/v3/coins/$id");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Unable to fetch data from Rest API');
    }
  }

  Future getTrendCrypto() async {
    Map<String, String> requestHeaders = {
      "content-type" : "application/json; charset=utf-8"
    };
    var url = Uri.https(baseURL, "/api/v3/search/trending");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception("Unable to fetch data from Rest API");
    }
  }

}