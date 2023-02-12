class Crypto {
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  num? marketCap;
  num? marketCapRank;
  num? marketCapChangePercentage;

  Crypto({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.marketCapChangePercentage
});

  Crypto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    symbol = json["symbol"];
    name = json["name"];
    image = json["image"];
    currentPrice = json["current_price"];
    marketCap = json["market_cap"];
    marketCapRank = json["market_cap_rank"];
    marketCapChangePercentage = json["market_cap_change_percentage_24h"];

  }

  Crypto.fromJsonTrend(Map<String, dynamic> json) {
    id = json["item"]["id"];
    symbol = json["item"]["symbol"];
    name = json["item"]["name"];
    image = json["item"]["thumb"];
    currentPrice = json["item"]["current_price"];
    marketCap = json["item"]["market_cap"];
    marketCapRank = json["item"]["market_cap_rank"];
    marketCapChangePercentage = json["item"]["market_cap_change_percentage_24h"];

  }


}