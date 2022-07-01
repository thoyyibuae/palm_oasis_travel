import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutvideo/screens/splash_page.dart';
// import 'Notifications.dart' as prefix0;
// import 'package:url_launcher/url_launcher.dart';
// import 'Deals.dart';
// import 'SecondPage.dart';
// import 'WishList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await EasyLocalization.ensureInitialized();

  runApp(
      EasyLocalization(
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    supportedLocales: [
      Locale("en"),
      Locale("ar"),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // BottomNav(),
      theme: appTheme,
      title: "Palm Oasis Travel",
    ),
  ));
}

double? width;
double? height;
ThemeData appTheme = ThemeData(
    primaryColor:
        // Colors.purple,
        Colors.blueAccent,
    secondaryHeaderColor: Colors.tealAccent,
    // highlightColor: Colors.grey,
    splashColor: Colors.grey.shade200
    /* Colors.teal*/
    // textTheme: TextTheme().apply(displayColor: Colors.deepPurple)
    // fontFamily:
    );
