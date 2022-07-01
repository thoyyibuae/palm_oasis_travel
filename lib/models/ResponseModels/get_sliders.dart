class GetSliders {
  GetSliders({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final List<SliderData> data;
  late final int total;
  late final int status;

  GetSliders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e) => SliderData.fromJson(e)).toList();
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

class SliderData {
  SliderData({
    required this.id,
    required this.image,
    this.link,
  });
  late final int id;
  late final String image;
  late final String? link;

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    link = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['link'] = link;
    return _data;
  }
}
