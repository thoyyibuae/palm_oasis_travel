import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tutvideo/models/ResponseModels/get_packages.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';
// import 'package:tutvideo/utils/services/rest_api_service.dart';
import 'package:tutvideo/widgets/homeScreen/home_countries.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Deals.dart';
// import '../SecondPage.dart';
import '../WishList.dart';
import 'package:tutvideo/Notifications.dart';

import '../main.dart';
import '../widgets/homeScreen/home_blogs.dart';
import '../widgets/homeScreen/home_packages.dart';
import '../widgets/homeScreen/home_slider.dart';
import 'visa_screen.dart';
// import 'package:tutvideo/main.dart' as prefix0;

int sel = 0;
TextStyle? viewallstyle;
final bodies = [HomeScreen(), WishList(), Deals(), Notifications()];

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: Colors.deepPurple.shade900,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Explore"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.favorite,
          color: Colors.deepPurple.shade900,
        ),
        icon: Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        label: "WishList"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.local_offer,
          color: Colors.deepPurple.shade900,
        ),
        icon: Icon(
          Icons.local_offer,
          color: Colors.black,
        ),
        label: "Deals"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.notifications,
          color: Colors.deepPurple.shade900,
        ),
        icon: Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        label: "Notifications"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    viewallstyle = TextStyle(fontSize: 14, color: Colors.deepPurple.shade900
        //  Theme.of(context).primaryColor //Colors.teal
        );
    return Scaffold(
        body: bodies.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel)
              setState(() {
                sel = index;
              });
          },
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    double h = 50;
    double w = 50;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("More Info :"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            onPrimary: Colors.white,
                          ),
                          child: Image.asset('assets/images/gmail.png'),
                          onPressed: () async {
                            const url = 'mailto:info@palmoasistravel.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            onPrimary: Colors.white,
                          ),
                          child: Image.asset('assets/images/instagram.png'),
                          onPressed: () async {
                            const url =
                                'https://www.instagram.com/palm_oasis_travel/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            onPrimary: Colors.white,
                          ),
                          child: Image.asset('assets/images/telegram.png'),
                          onPressed: () async {
                            const url = 'https://twitter.com/palmoasis_';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            onPrimary: Colors.white,
                          ),
                          child: Image.asset('assets/images/whatsapp.png'),
                          onPressed: () async {
                            const url = 'https://wa.me/+971504100505';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.info_outline),
        backgroundColor: //appTheme.primaryColor
            Colors.deepPurple.shade900.withOpacity(.5),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeTop(),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              // runAlignment: WrapAlignment.start,
              children: [
                InkWell(

                    // iconSize: kMinInteractiveDimension,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return VisaScreen();
                      }));
                    }, //                          child: Image.asset('assets/images/gmail.png'),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/passport.png',
                            height: kMinInteractiveDimension,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            'Book UAE visa',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.apply(color: Theme.of(context).primaryColor),
                          )
                          // Text(
                          //   'visa',
                          //   style: Theme.of(context).textTheme.button,
                          // ).tr()
                        ],
                      ),
                    ))
              ],
            ),
            HomePackagesSection(),
            HomeCountriesSection(),
            HomeBlogs()
            // countries,
          ],
        ),
      ),
    );
  }
}

// var selectedloc = 0;
// List<String> locs = ['Kerman (KER)', 'Mashhad (MASH)'];

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
  var isFlightselected = true;
  TextEditingController c = TextEditingController(//text: locs[1]
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            // height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor
            ])),
            child: Column(
              children: <Widget>[
                HomeSlider(),

                // SizedBox(
                //   height: height! / 16,
                // ),
                // Padding(
                //   padding: EdgeInsets.all(16.0),
                //   child: Row(
                //     children: <Widget>[
                //       // Icon(
                //       //   Icons.location_on,
                //       //   color: Colors.deepPurple.shade900,
                //       // ),
                //       // SizedBox(
                //       //   width: width! * 0.05,
                //       // ),
                //       // PopupMenuButton(
                //       //   onSelected: (index) {
                //       //     setState(() {
                //       //       selectedloc = int.parse(index.toString());
                //       //     });
                //       //   },
                //       //   child: Row(
                //       //     children: <Widget>[
                //       //       Text(
                //       //         locs[selectedloc],
                //       //         style: TextStyle(
                //       //           color: Colors.deepPurple.shade900,
                //       //           fontSize: 16.0,
                //       //         ),
                //       //       ),
                //       //       Icon(
                //       //         Icons.keyboard_arrow_down,
                //       //         color: Colors.deepPurple.shade900,
                //       //       )
                //       //     ],
                //       //   ),
                //       //   itemBuilder: (BuildContext context) {
                //       //     return <PopupMenuItem<int>>[
                //       //       PopupMenuItem(
                //       //         child: Text(
                //       //           locs[0],
                //       //           style: TextStyle(
                //       //             color: Colors.black,
                //       //             fontSize: 16.0,
                //       //           ),
                //       //         ),
                //       //         value: 0,
                //       //       ),
                //       //       PopupMenuItem(
                //       //         child: Text(
                //       //           locs[1],
                //       //           style: TextStyle(
                //       //             color: Colors.black,
                //       //             fontSize: 16.0,
                //       //           ),
                //       //         ),
                //       //         value: 1,
                //       //       )
                //       //     ];
                //       //   },
                //       // ),

                //       Spacer(),
                //       Icon(
                //         Icons.settings,
                //         color: Colors.deepPurple.shade900,
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: height! / 16,
                // ),
                // Text(
                //   'Where Would  \n you want to go',
                //   style: TextStyle(
                //     fontSize: 24.0,
                //     color: Colors.deepPurple.shade900,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(height: height! * 0.0375),
                // Container(
                //   width: 300,
                //   padding: EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Material(
                //     elevation: 5.0,
                //     borderRadius: BorderRadius.all(Radius.circular(30)),
                //     child: TextField(
                //       controller: c,
                //       style: TextStyle(
                //         fontSize: 16.0,
                //         color: Colors.black,
                //       ),
                //       cursorColor: Theme.of(context).primaryColor,
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           contentPadding: EdgeInsets.symmetric(
                //               horizontal: 32, vertical: 13),
                //           suffixIcon: Material(
                //             child: InkWell(
                //               child: Icon(
                //                 Icons.search,
                //                 color: Colors.black,
                //               ),
                //               onTap: () {
                //                 Navigator.push(context,
                //                     MaterialPageRoute(builder: (context) {
                //                   return SecondPage(
                //                       fromloc: 'loc',
                //                       // locs[selectedloc],
                //                       toloc: c.text);
                //                 }));
                //               },
                //             ),
                //             elevation: 2.0,
                //             borderRadius: BorderRadius.all(Radius.circular(30)),
                //           )),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: height! * 0.025,
                // ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     InkWell(
                //       child: Choice08(
                //           icon: FontAwesomeIcons.suitcase,
                //           text: "Packages",
                //           selected: isFlightselected),
                //       onTap: () {
                //         setState(() {
                //           isFlightselected = true;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //       width: width! * 0.055,
                //     ),
                //     InkWell(
                //       child: Choice08(
                //           icon: FontAwesomeIcons.globe,
                //           text: "Countries",
                //           selected: !isFlightselected),
                //       onTap: () {
                //         setState(() {
                //           isFlightselected = false;
                //         });
                //       },
                //     )
                //   ],
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  Choice08({this.icon, this.text, this.selected});
  @override
  _Choice08State createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.deepPurple.shade900.withOpacity(.30),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.deepPurple.shade900,
          ),
          SizedBox(
            width: width! * .025,
          ),
          Text(
            widget.text!,
            style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 16),
          )
        ],
      ),
    );
  }
}

// var homeDown = ;
// var countries = Column(
//   children: <Widget>[
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           // SizedBox(
//           //   width: width! * 0.05,
//           // ),
//           Text(
//             "Popular Countries",
//             style: TextStyle(color: Colors.black, fontSize: 16),
//           ),
//           Spacer(),
//           Text("VIEW ALL", style: viewallstyle)
//         ],
//       ),
//     ),
//     Container(
//       height: height! * .25 < 170 ? height! * .25 : 170,
//       //height: height! * .25 < 300 ? height! * .25 : 300,
//       // child:
//       // ConstrainedBox(
//       //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
//       child: ListView.builder(
//           itemBuilder: (context, index) => cities[index],
//           shrinkWrap: true,
//           padding: EdgeInsets.all(0.0),
//           itemCount: cities.length,
//           scrollDirection: Axis.horizontal),
//     ),
//   ],
// );
// List<City> cities = [
//   City(
//     image: "assets/images/Kerman.png",
//     name: "Kerman",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
//   City(
//     image: "assets/images/Mashhad.png",
//     name: "Mashhad",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
//   City(
//     image: "assets/images/Tehran.png",
//     name: "Tehran",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
// ];

class City extends StatelessWidget {
  final String? image, monthyear, oldprice;
  final String? name, discount, newprice;

  const City(
      {Key? key,
      this.image,
      this.monthyear,
      this.oldprice,
      this.name,
      this.discount,
      this.newprice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                if (image != null && image!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Hero(
                      tag: image!,
                      child: CachedNetworkImage(
                          imageUrl: image!,
                          cacheKey: image!,
                          placeholder: (_, __) {
                            return BasicScreen.buildShimmer(
                                true,
                                Container(
                                  height: height! * .137 < 160
                                      ? height! * .137
                                      : 160,
                                  width: width! * .5 < 250 ? width! * .5 : 250,
                                ));
                          },
                          errorWidget: (_, __, ___) => Stack(
                                children: [
                                  Container(
                                    height: height! * .137 < 160
                                        ? height! * .137
                                        : 160,
                                    width:
                                        width! * .5 < 250 ? width! * .5 : 250,
                                    color: Colors.grey.shade900,
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    height: 60,
                                    width:
                                        width! * .5 < 250 ? width! * .5 : 250,
                                    left: 0,
                                    //right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            Colors.black,
                                            Colors.black12
                                          ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter)),
                                    ),
                                  ),
                                  Positioned(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          width: width! * .4 < 250
                                              ? width! * .4
                                              : 250,

                                          //decoration: BoxDecoration(
                                          //   shape: BoxShape.rectangle,
                                          //   color: Colors.black.withOpacity(.4),
                                          //  borderRadius: BorderRadius.all(Radius.circular(10))
                                          // ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                name!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.white),
                                              ),
                                              // Text(
                                              //   monthyear!,
                                              //   style: TextStyle(
                                              //       fontSize: 14,
                                              //       fontWeight: FontWeight.w400,
                                              //       color: Colors.white),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   padding:
                                        //       EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        //   decoration: BoxDecoration(
                                        //       shape: BoxShape.rectangle,
                                        //       color: Colors.white,
                                        //       borderRadius:
                                        //           BorderRadius.all(Radius.circular(10))),
                                        //   child: Text(
                                        //     discount! + "%",
                                        //     style: TextStyle(
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: Colors.black),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    left: 5,
                                    bottom: 10,
                                    right: 10,
                                  )
                                ],
                              ),
                          imageBuilder: (_, imageProvider) {
                            return Container(
                              height:
                                  height! * .137 < 160 ? height! * .137 : 160,
                              width: width! * .5 < 250 ? width! * .5 : 250,
                              //   child: Image.asset(image,fit: BoxFit.cover,)
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill)),
                            );
                          }),
                    ),
                  ),
              ],
            )),
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Text("\$ " + '${(newprice)}',
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold,
        //             fontStyle: FontStyle.italic)),
        //     SizedBox(
        //       width: width! * 0.08,
        //     ),
        //     Text("\$ " + '${(oldprice)}',
        //         style: TextStyle(
        //             color: Colors.black87,
        //             fontWeight: FontWeight.w400,
        //             fontStyle: FontStyle.italic)),
        //   ],
        // )
      ],
    );
  }
}
