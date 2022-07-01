class GetPackages {
  GetPackages({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.message,
    required this.status,
  });
  late final List<Package> data;
  late final Links links;
  late final Meta meta;
  late final bool success;
  late final String message;
  late final int status;

  GetPackages.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Package.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    _data['success'] = success;
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}

class Package {
  Package({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.labels,
    required this.flight,
    required this.hotels,
    required this.transfer,
    required this.activity,
    required this.packageHotels,
  });
  late final int id;
  late final String name;
  late final String symbol;
  late final String image;
  late final List<dynamic> labels;
  late final int flight;
  late final int hotels;
  late final int transfer;
  late final int activity;
  late final List<PackageHotels> packageHotels;

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    image = json['image'];
    labels = List.castFrom<dynamic, dynamic>(json['labels']);
    flight = json['flight'];
    hotels = json['hotels'];
    transfer = json['transfer'];
    activity = json['activity'];
    packageHotels = List.from(json['package_hotels'])
        .map((e) => PackageHotels.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['symbol'] = symbol;
    _data['image'] = image;
    _data['labels'] = labels;
    _data['flight'] = flight;
    _data['hotels'] = hotels;
    _data['transfer'] = transfer;
    _data['activity'] = activity;
    _data['package_hotels'] = packageHotels.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PackageHotels {
  PackageHotels({
    required this.id,
    required this.soldOut,
    required this.starRate,
    required this.price,
    required this.hotelId,
  });
  late final int id;
  late final int soldOut;
  late final int starRate;
  late final String price;
  late final int hotelId;

  PackageHotels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soldOut = json['sold_out'];
    starRate = json['star_rate'];
    price = json['price'];
    hotelId = json['hotel_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sold_out'] = soldOut;
    _data['star_rate'] = starRate;
    _data['price'] = price;
    _data['hotel_id'] = hotelId;
    return _data;
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });
  late final String first;
  late final String last;
  late final Null prev;
  late final String next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = null;
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['prev'] = prev;
    _data['next'] = next;
    return _data;
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}
// class GetPackages {
//   GetPackages({
//     required this.success,
//     required this.message,
//     required this.data,
//     required this.total,
//     required this.status,
//   });
//   late final bool success;
//   late final String message;
//   late final List<Package> data;
//   late final int total;

//   late final int status;

//   GetPackages.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = List.from(json['data']).map((e) => Package.fromJson(e)).toList();
//     total = json['total'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['message'] = message;
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     _data['total'] = total;
//     _data['status'] = status;
//     return _data;
//   }
// }

// class Package {
//   Package({
//     required this.id,
//     required this.publishDate,
//     required this.suppressDate,
//     this.passengerDetails,
//     required this.flight,
//     required this.country,
//     required this.city,
//     required this.hotels,
//     required this.transfer,
//     required this.activity,
//     this.video,
//     required this.date,
//     required this.number,
//     required this.openInclude,
//     required this.openNotInclude,
//     required this.openTerm,
//     required this.openCancellation,
//     required this.openAdditionalInfo,
//     required this.symbol,
//     required this.name,
//     this.destination,
//     this.region,
//     this.category,
//     required this.overview,
//     required this.termsCondition,
//     this.cancellationPolicy,
//     this.additionalInfo,
//     required this.packageOrder,
//     required this.pdf,
//     required this.packageImageHeader,
//     required this.image,
//     required this.map,
//   });
//   late final int id;
//   late final String publishDate;
//   late final String suppressDate;
//   late final dynamic passengerDetails;
//   late final String flight;
//   late final String country;
//   late final String city;
//   late final String hotels;
//   late final String transfer;
//   late final String activity;
//   late final String? video;
//   late final String date;
//   late final String number;
//   late final String openInclude;
//   late final String openNotInclude;
//   late final String openTerm;
//   late final String openCancellation;
//   late final String openAdditionalInfo;
//   late final String symbol;
//   late final String name;
//   late final String? destination;
//   late final dynamic region;
//   late final String? category;
//   late final String overview;
//   late final String termsCondition;
//   late final String? cancellationPolicy;
//   late final dynamic additionalInfo;
//   late final String packageOrder;
//   late final String pdf;
//   late final String packageImageHeader;
//   late final String image;
//   late final String map;

//   Package.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     publishDate = json['publish_date'];
//     suppressDate = json['suppress_date'];
//     passengerDetails = null;
//     flight = json['flight'];
//     country = json['country'];
//     city = json['city'];
//     hotels = json['hotels'];
//     transfer = json['transfer'];
//     activity = json['activity'];
//     video = null;
//     date = json['date'];
//     number = json['number'];
//     openInclude = json['open_include'];
//     openNotInclude = json['open_not_include'];
//     openTerm = json['open_term'];
//     openCancellation = json['open_cancellation'];
//     openAdditionalInfo = json['open_additional_info'];
//     symbol = json['symbol'];
//     name = json['name'];
//     destination = null;
//     region = null;
//     category = null;
//     overview = json['overview'];
//     termsCondition = json['terms_condition'];
//     cancellationPolicy = null;
//     additionalInfo = null;
//     packageOrder = json['package_order'];
//     pdf = json['pdf'];
//     packageImageHeader = json['package_image_header'];
//     image = json['image'];
//     map = json['map'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['publish_date'] = publishDate;
//     _data['suppress_date'] = suppressDate;
//     _data['passenger_details'] = passengerDetails;
//     _data['flight'] = flight;
//     _data['country'] = country;
//     _data['city'] = city;
//     _data['hotels'] = hotels;
//     _data['transfer'] = transfer;
//     _data['activity'] = activity;
//     _data['video'] = video;
//     _data['date'] = date;
//     _data['number'] = number;
//     _data['open_include'] = openInclude;
//     _data['open_not_include'] = openNotInclude;
//     _data['open_term'] = openTerm;
//     _data['open_cancellation'] = openCancellation;
//     _data['open_additional_info'] = openAdditionalInfo;
//     _data['symbol'] = symbol;
//     _data['name'] = name;
//     _data['destination'] = destination;
//     _data['region'] = region;
//     _data['category'] = category;
//     _data['overview'] = overview;
//     _data['terms_condition'] = termsCondition;
//     _data['cancellation_policy'] = cancellationPolicy;
//     _data['additional_info'] = additionalInfo;
//     _data['package_order'] = packageOrder;
//     _data['pdf'] = pdf;
//     _data['package_image_header'] = packageImageHeader;
//     _data['image'] = image;
//     _data['map'] = map;
//     return _data;
//   }
// }
