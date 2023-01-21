class Crypto {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? marketCapChangePercentage;

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

}