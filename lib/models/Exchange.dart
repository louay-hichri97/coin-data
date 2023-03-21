class Exchange {
  String? id;
  String? name;
  String? image;
  String? url;
  num? trustScore;


  Exchange({
    this.id,
    this.name,
    this.image,
    this.trustScore,
  });

  Exchange.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    trustScore = json["trust_score"];
    url = json["url"];

  }




}