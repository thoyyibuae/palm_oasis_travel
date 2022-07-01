class GetVisaNationalities {
  GetVisaNationalities({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final List<VisaNationality> data;
  late final int total;
  late final int status;

  GetVisaNationalities.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = List.from(json['data'])
        .map((e) => VisaNationality.fromJson(e))
        .toList();
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

class VisaNationality {
  VisaNationality({
    required this.id,
    required this.name,
    this.text,
    required this.headerImage,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String? text;
  late final String headerImage;
  late final String image;

  VisaNationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = null;
    headerImage = json['header_image'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['text'] = text;
    _data['header_image'] = headerImage;
    _data['image'] = image;
    return _data;
  }
}
