import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tutvideo/models/ResponseModels/get_blogs.dart';
import 'package:tutvideo/screens/blog_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import '../../main.dart';
import '../../screens/bottom_nav.dart';
import '../../utils/helpers/basic_screen.dart';
import '../../utils/services/rest_api_service.dart';

class HomeBlogs extends StatefulWidget {
  const HomeBlogs({Key? key}) : super(key: key);

  @override
  _HomeBlogsState createState() => _HomeBlogsState();
}

class _HomeBlogsState extends State<HomeBlogs> {
  List<Blog> _blogs = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context)
            .blogs
            .then((value) => setState((() => _blogs = value ?? []))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(
              //   width: width! * 0.05,
              // ),
              Text(
                "Latest News",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("VIEW ALL", style: viewallstyle)
            ],
          ),
        ),
        // Container(
        // height: height! * .25 < 170 ? height! * .25 : 170,
        //height: height! * .25 < 300 ? height! * .25 : 300,
        // child:
        // ConstrainedBox(
        //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
        // child:
        _blogs.isEmpty
            ? BasicScreen.buildShimmer(
                true,
                Container(
                  height: 200,
                  color: Colors.blue,
                  width: double.maxFinite,
                ))
            // Container(
            //     height: 30,
            //     alignment: Alignment.center,
            //     child: CircularProgressIndicator(strokeWidth: 5),
            //   )
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final blog = _blogs.isEmpty ? null : _blogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: (blog == null)
                        ? BasicScreen.buildShimmer(
                            true,
                            Container(
                              height: 200,
                              color: Colors.blue,
                              width: double.maxFinite,
                            ))
                        : InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogScreen(blog: blog),
                                )),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                if (blog.image.isNotEmpty)
                                  Hero(
                                    tag: blog.image,
                                    child: CachedNetworkImage(
                                      height: 200,
                                      cacheKey: blog.image,
                                      imageUrl: blog.image,
                                      placeholder: (_, __) =>
                                          BasicScreen.buildShimmer(
                                              true,
                                              Container(
                                                height: 200,
                                                color: Colors.blue,
                                                width: double.maxFinite,
                                              )),
                                      errorWidget: (_, __, ___) => Container(
                                        height: 200,
                                        width: double.maxFinite,
                                        color: Colors.grey.shade500,
                                        child: Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  // height: 75,
                                  padding: EdgeInsets.all(8),
                                  width: double.maxFinite,
                                  color: Colors.black.withOpacity(0.5),
                                  alignment: context.locale.languageCode == 'en'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Hero(
                                    tag: blog.name,
                                    child: Text(
                                      blog.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.apply(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  );

//               City(
//                 image: package.image,
//                 name: package.name,
// // discount: package.,
//               );
                },
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemCount: _blogs.isEmpty ? 3 : _blogs.length,
                scrollDirection: Axis.vertical),
        // ),
      ],
    );
  }
}
