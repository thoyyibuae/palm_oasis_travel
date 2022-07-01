class GetVisaRequirements {
  GetVisaRequirements({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final VisaRequirements data;
  late final int total;
  late final int status;

  GetVisaRequirements.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = VisaRequirements.fromJson(json['data']);
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

class VisaRequirements {
  VisaRequirements({
    required this.id,
    required this.processingTime,
    required this.visaValidity,
    required this.stayValidity,
    required this.adultPrice,
    required this.childPrice,
    required this.infantPrice,
    required this.requirements,
  });
  late final int id;
  late final String processingTime;
  late final String visaValidity;
  late final String stayValidity;
  late final int adultPrice;
  late final int childPrice;
  late final int infantPrice;
  late final List<String> requirements;

  VisaRequirements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    processingTime = json['processing_time'];
    visaValidity = json['visa_validity'];
    stayValidity = json['stay_validity'];
    adultPrice = json['adult_price'];
    childPrice = json['child_price'];
    infantPrice = json['infant_price'];
    requirements = List.castFrom<dynamic, String>(json['requirements']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['processing_time'] = processingTime;
    _data['visa_validity'] = visaValidity;
    _data['stay_validity'] = stayValidity;
    _data['adult_price'] = adultPrice;
    _data['child_price'] = childPrice;
    _data['infant_price'] = infantPrice;
    _data['requirements'] = requirements;
    return _data;
  }
}
