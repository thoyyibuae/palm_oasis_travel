import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tutvideo/models/ResponseModels/get_blogs.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';

class BlogScreen extends StatefulWidget {
  final Blog blog;
  const BlogScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('latestNews'.tr()),
        ),
        body: SingleChildScrollView(
            // padding: EdgeInsets.all(15),
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (widget.blog.image.isNotEmpty)
              Hero(
                tag: widget.blog.image,
                child: CachedNetworkImage(
                  cacheKey: widget.blog.image,
                  imageUrl: widget.blog.image,
                  placeholder: (_, __) => SizedBox.shrink(),
                  errorWidget: (_, __, ___) => SizedBox.shrink(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: widget.blog.name,
                child: Text(
                  widget.blog.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: HtmlWidget(widget.blog.info),
            ),
          ],
        ))

        //  Text(widget.blog.info),
        );
  }
}
