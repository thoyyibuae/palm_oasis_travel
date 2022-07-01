class GetPackageDetails {
  GetPackageDetails({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final PackageDetails data;
  late final int total;
  late final int status;

  GetPackageDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = PackageDetails.fromJson(json['data']);
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

class PackageDetails {
  PackageDetails({
    required this.id,
    required this.symbol,
    required this.name,
    required this.pdf,
    required this.packageImageHeader,
    required this.map,
    required this.video,
    required this.overview,
    required this.openInclude,
    required this.openNotInclude,
    required this.openTerm,
    required this.termsCondition,
    required this.openCancellation,
    required this.cancellationPolicy,
    required this.openAdditionalInfo,
    this.additionalInfo,
    required this.sliders,
    required this.inclusions,
    required this.exclusions,
    required this.days,
    required this.flights,
    required this.transfers,
  });
  late final int id;
  late final String symbol;
  late final String name;
  late final String pdf;
  late final String packageImageHeader;
  late final String map;
  late final String video;
  late final String overview;
  late final int openInclude;
  late final int openNotInclude;
  late final int openTerm;
  late final String termsCondition;
  late final int openCancellation;
  late final String cancellationPolicy;
  late final int openAdditionalInfo;
  late final Null additionalInfo;
  late final List<Sliders> sliders;
  late final List<Inclusions> inclusions;
  late final List<Exclusions> exclusions;
  late final List<Days> days;
  late final List<Flights> flights;
  late final List<Transfers> transfers;

  PackageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    pdf = json['pdf'];
    packageImageHeader = json['package_image_header'];
    map = json['map'];
    video = json['video'];
    overview = json['overview'];
    openInclude = json['open_include'];
    openNotInclude = json['open_not_include'];
    openTerm = json['open_term'];
    termsCondition = json['terms_condition'];
    openCancellation = json['open_cancellation'];
    cancellationPolicy = json['cancellation_policy'];
    openAdditionalInfo = json['open_additional_info'];
    additionalInfo = null;
    sliders =
        List.from(json['sliders']).map((e) => Sliders.fromJson(e)).toList();
    inclusions = List.from(json['inclusions'])
        .map((e) => Inclusions.fromJson(e))
        .toList();
    exclusions = List.from(json['exclusions'])
        .map((e) => Exclusions.fromJson(e))
        .toList();
    days = List.from(json['days']).map((e) => Days.fromJson(e)).toList();
    flights =
        List.from(json['flights']).map((e) => Flights.fromJson(e)).toList();
    transfers =
        List.from(json['transfers']).map((e) => Transfers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['symbol'] = symbol;
    _data['name'] = name;
    _data['pdf'] = pdf;
    _data['package_image_header'] = packageImageHeader;
    _data['map'] = map;
    _data['video'] = video;
    _data['overview'] = overview;
    _data['open_include'] = openInclude;
    _data['open_not_include'] = openNotInclude;
    _data['open_term'] = openTerm;
    _data['terms_condition'] = termsCondition;
    _data['open_cancellation'] = openCancellation;
    _data['cancellation_policy'] = cancellationPolicy;
    _data['open_additional_info'] = openAdditionalInfo;
    _data['additional_info'] = additionalInfo;
    _data['sliders'] = sliders.map((e) => e.toJson()).toList();
    _data['inclusions'] = inclusions.map((e) => e.toJson()).toList();
    _data['exclusions'] = exclusions.map((e) => e.toJson()).toList();
    _data['days'] = days.map((e) => e.toJson()).toList();
    _data['flights'] = flights.map((e) => e.toJson()).toList();
    _data['transfers'] = transfers.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Sliders {
  Sliders({
    this.text,
    required this.image,
  });
  late final Null text;
  late final String image;

  Sliders.fromJson(Map<String, dynamic> json) {
    text = null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['image'] = image;
    return _data;
  }
}

class Inclusions {
  Inclusions({
    required this.value,
  });
  late final String value;

  Inclusions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    return _data;
  }
}

class Exclusions {
  Exclusions({
    required this.value,
  });
  late final String value;

  Exclusions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    return _data;
  }
}

class Days {
  Days({
    required this.dayTitle,
    required this.openDay,
    required this.dayDescription,
  });
  late final String dayTitle;
  late final int openDay;
  late final String dayDescription;

  Days.fromJson(Map<String, dynamic> json) {
    dayTitle = json['day_title'];
    openDay = json['open_day'];
    dayDescription = json['day_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day_title'] = dayTitle;
    _data['open_day'] = openDay;
    _data['day_description'] = dayDescription;
    return _data;
  }
}

class Flights {
  Flights({
    required this.departureFrom,
    required this.departureTo,
    required this.segments,
  });
  late final String departureFrom;
  late final String departureTo;
  late final Segments segments;

  Flights.fromJson(Map<String, dynamic> json) {
    departureFrom = json['departure_from'];
    departureTo = json['departure_to'];
    segments = Segments.fromJson(json['segments']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['departure_from'] = departureFrom;
    _data['departure_to'] = departureTo;
    _data['segments'] = segments.toJson();
    return _data;
  }
}

class Segments {
  Segments({
    required this.icon,
    required this.flight,
    required this.flightNumber,
    required this.departureFrom,
    required this.departureDate,
    this.departureTime,
    required this.arrivalTo,
    this.arrivalDate,
    this.arrivalTime,
  });
  late final String icon;
  late final String flight;
  late final String flightNumber;
  late final String departureFrom;
  late final String departureDate;
  late final Null departureTime;
  late final String arrivalTo;
  late final Null arrivalDate;
  late final Null arrivalTime;

  Segments.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    flight = json['flight'];
    flightNumber = json['flight_number'];
    departureFrom = json['departure_from'];
    departureDate = json['departure_date'];
    departureTime = null;
    arrivalTo = json['arrival_to'];
    arrivalDate = null;
    arrivalTime = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['icon'] = icon;
    _data['flight'] = flight;
    _data['flight_number'] = flightNumber;
    _data['departure_from'] = departureFrom;
    _data['departure_date'] = departureDate;
    _data['departure_time'] = departureTime;
    _data['arrival_to'] = arrivalTo;
    _data['arrival_date'] = arrivalDate;
    _data['arrival_time'] = arrivalTime;
    return _data;
  }
}

class Transfers {
  Transfers({
    required this.type,
    required this.image,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.date,
    required this.time,
  });
  late final String type;
  late final String image;
  late final String pickupLocation;
  late final String dropOffLocation;
  late final String date;
  late final String time;

  Transfers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    image = json['image'];
    pickupLocation = json['pickup_location'];
    dropOffLocation = json['drop_off_location'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['image'] = image;
    _data['pickup_location'] = pickupLocation;
    _data['drop_off_location'] = dropOffLocation;
    _data['date'] = date;
    _data['time'] = time;
    return _data;
  }
}
