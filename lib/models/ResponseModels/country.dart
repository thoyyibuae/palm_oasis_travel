class Country {
  Country({
    required this.id,
    required this.name,
    required this.symbol,
    required this.startPrice,
    required this.countryOrder,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String symbol;
  late final String startPrice;
  late final String? countryOrder;
  late final String image;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    startPrice = json['start_price'];
    countryOrder = json['country_order'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['symbol'] = symbol;
    _data['start_price'] = startPrice;
    _data['country_order'] = countryOrder;
    _data['image'] = image;
    return _data;
  }
}
