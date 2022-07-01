class GetCountryDetails {
  GetCountryDetails({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final CountryDetails data;
  late final int total;
  late final int status;

  GetCountryDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = CountryDetails.fromJson(json['data']);
    total = json['total'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['total'] = total;
    _data['status'] = status;
    return _data;
  }
}

class CountryDetails {
  CountryDetails({
    required this.id,
    required this.name,
    required this.capital,
    required this.currency,
    required this.convertCurrency,
    required this.officialLang,
    required this.visaInfo,
    required this.intro,
    required this.symbol,
    required this.startPrice,
    required this.countryOrder,
    required this.image,
    required this.flag,
    required this.headerImage,
  });
  late final int id;
  late final String name;
  late final String capital;
  late final String currency;
  late final String convertCurrency;
  late final String officialLang;
  late final String visaInfo;
  late final String? intro;
  late final String symbol;
  late final String startPrice;
  late final String countryOrder;
  late final String image;
  late final String flag;
  late final String headerImage;

  CountryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capital = json['capital'];
    currency = json['currency'];
    convertCurrency = json['convert_currency'];
    officialLang = json['official_lang'];
    visaInfo = json['visa_info'];
    intro = json['intro'];
    symbol = json['symbol'];
    startPrice = json['start_price'];
    countryOrder = json['country_order'];
    image = json['image'];
    flag = json['flag'];
    headerImage = json['header_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['capital'] = capital;
    _data['currency'] = currency;
    _data['convert_currency'] = convertCurrency;
    _data['official_lang'] = officialLang;
    _data['visa_info'] = visaInfo;
    _data['intro'] = intro;
    _data['symbol'] = symbol;
    _data['start_price'] = startPrice;
    _data['country_order'] = countryOrder;
    _data['image'] = image;
    _data['flag'] = flag;
    _data['header_image'] = headerImage;
    return _data;
  }
}
