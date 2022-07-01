import 'package:flutter/material.dart';
import 'package:tutvideo/screens/package_screen.dart';

import '../../main.dart';
import '../../models/ResponseModels/get_packages.dart';
import '../../screens/bottom_nav.dart';
import '../../utils/helpers/basic_screen.dart';
import '../../utils/helpers/screen_size.dart';
import '../../utils/services/rest_api_service.dart';

class HomePackagesSection extends StatefulWidget {
  const HomePackagesSection({Key? key}) : super(key: key);

  @override
  _HomePackagesSectionState createState() => _HomePackagesSectionState();
}

class _HomePackagesSectionState extends State<HomePackagesSection> {
  List<Package> _packages = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context)
            .packages
            .then((value) => setState((() => _packages = value ?? []))));
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
                "Trending Packages",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("VIEW ALL", style: viewallstyle)
            ],
          ),
        ),
        Container(
          height: height! * .15 < 170 ? height! * .15 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
          // child:
          // ConstrainedBox(
          //   constraints: BoxConstraints(ma xHeight: 170, minHeight: height! * .13),
          child: ListView.builder(
              itemBuilder: (context, index) {
                final package = _packages.isEmpty ? null : _packages[index];
                return (package == null)
                    ? BasicScreen.buildShimmer(
                        true,
                        Container(
                            height: height! * .15 < 170 ? height! * .15 : 170,
                            width: ScreenSize.width(context)))
                    : InkWell(
                        // splashColor: Colors.grey.shade500,
                        // focusColor: Colors.grey.shade500,
                        // hoverColor: Colors.grey.shade500,
                        highlightColor: Colors.grey.shade500,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PackageScreen(package: package),
                            )),
                        child: City(
                          image: package.image,
                          name: package.name,
                          // discount: package.,
                        ),
                      );
              },
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemCount: _packages.isEmpty ? 3 : _packages.length,
              scrollDirection: Axis.horizontal),
        ),
      ],
    );
  }
}
