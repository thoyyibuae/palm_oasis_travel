import 'package:tutvideo/models/ResponseModels/country.dart';

class GetHomepageCountries {
  GetHomepageCountries({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final List<Country> data;
  late final int total;
  late final int status;

  GetHomepageCountries.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Country.fromJson(e)).toList();
    total = json['total'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['total'] = total;
    _data['status'] = status;
    return _data;
  }
}

// class Data {
//   Data({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.startPrice,
//     required this.image,
//   });
//   late final int id;
//   late final String name;
//   late final String symbol;
//   late final String startPrice;
//   late final String image;

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     symbol = json['symbol'];
//     startPrice = json['start_price'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['symbol'] = symbol;
//     _data['start_price'] = startPrice;
//     _data['image'] = image;
//     return _data;
//   }
// }
