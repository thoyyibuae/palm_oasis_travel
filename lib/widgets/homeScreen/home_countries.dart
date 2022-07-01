import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/ResponseModels/country.dart';
import '../../models/ResponseModels/get_countries.dart';
import '../../screens/bottom_nav.dart';
import '../../screens/country_screen.dart';
import '../../utils/helpers/basic_screen.dart';
import '../../utils/helpers/screen_size.dart';
import '../../utils/services/rest_api_service.dart';

class HomeCountriesSection extends StatefulWidget {
  const HomeCountriesSection({Key? key}) : super(key: key);

  @override
  _HomeCountriesSectionState createState() => _HomeCountriesSectionState();
}

class _HomeCountriesSectionState extends State<HomeCountriesSection> {
  List<Country> _countries = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context).homepageCountries.then((value) {
              setState((() => _countries = value ?? []));
            }));
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
                "Exciting Countries",
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
          //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
          child: ListView.builder(
              itemBuilder: (context, index) {
                final country = _countries.isEmpty ? null : _countries[index];
                return (country == null)
                    ? BasicScreen.buildShimmer(
                        true,
                        Container(
                            height: height! * .15 < 170 ? height! * .15 : 170,
                            color: Colors.blue,
                            width: ScreenSize.width(context)))

                    // width: double.maxFinite,

                    : InkWell(
                        // splashColor: Colors.grey.shade500,
                        // focusColor: Colors.grey.shade500,
                        // hoverColor: Colors.grey.shade500,
                        highlightColor: Colors.grey.shade500,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryScreen(country: country),
                            )),
                        child: City(
                          image: country.image,
                          name: country.name,
// discount: country.,
                        ),
                      );
              },
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemCount: _countries.isEmpty ? 3 : _countries.length,
              scrollDirection: Axis.horizontal),
        ),
      ],
    );
  }
}
