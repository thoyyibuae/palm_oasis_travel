class GetBlogDetails {
  GetBlogDetails({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.status,
  });
  late final bool success;
  late final String message;
  late final BlogDetails data;
  late final int total;
  late final int status;

  GetBlogDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = BlogDetails.fromJson(json['data']);
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

class BlogDetails {
  BlogDetails({
    required this.id,
    required this.name,
    required this.info,
    required this.symbol,
    required this.image,
    required this.headerImage,
    required this.comments,
  });
  late final int id;
  late final String name;
  late final String info;
  late final String symbol;
  late final String image;
  late final String headerImage;
  late final List<Comments> comments;

  BlogDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    symbol = json['symbol'];
    image = json['image'];
    headerImage = json['header_image'];
    comments =
        List.from(json['comments']).map((e) => Comments.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['info'] = info;
    _data['symbol'] = symbol;
    _data['image'] = image;
    _data['header_image'] = headerImage;
    _data['comments'] = comments.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Comments {
  Comments({
    required this.commenterName,
    required this.commentText,
  });
  late final String commenterName;
  late final String commentText;

  Comments.fromJson(Map<String, dynamic> json) {
    commenterName = json['commenter_name'];
    commentText = json['comment_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['commenter_name'] = commenterName;
    _data['comment_text'] = commentText;
    return _data;
  }
}
