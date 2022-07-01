class GetBlogs {
  GetBlogs({
    required this.data,
    required this.globalInfo,
    required this.links,
    required this.meta,
    required this.success,
    required this.message,
    required this.status,
  });
  late final List<Blog> data;
  late final GlobalInfo globalInfo;
  late final Links links;
  late final Meta meta;
  late final bool success;
  late final String message;
  late final int status;

  GetBlogs.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Blog.fromJson(e)).toList();
    globalInfo = GlobalInfo.fromJson(json['global_info']);
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['global_info'] = globalInfo.toJson();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    _data['success'] = success;
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}

class Blog {
  Blog({
    required this.id,
    required this.name,
    required this.info,
    required this.symbol,
    required this.image,
    required this.headerImage,
    required this.slider,
  });
  late final int id;
  late final String name;
  late final String info;
  late final String symbol;
  late final String image;
  late final String headerImage;
  late final List<dynamic> slider;

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    symbol = json['symbol'];
    image = json['image'];
    headerImage = json['header_image'];
    slider = List.castFrom<dynamic, dynamic>(json['slider']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['info'] = info;
    _data['symbol'] = symbol;
    _data['image'] = image;
    _data['header_image'] = headerImage;
    _data['slider'] = slider;
    return _data;
  }
}

class GlobalInfo {
  GlobalInfo({
    required this.intro,
    required this.headerImage,
  });
  late final String intro;
  late final String headerImage;

  GlobalInfo.fromJson(Map<String, dynamic> json) {
    intro = json['intro'];
    headerImage = json['header_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['intro'] = intro;
    _data['header_image'] = headerImage;
    return _data;
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });
  late final String first;
  late final String last;
  late final Null prev;
  late final Null next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = null;
    next = null;
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
