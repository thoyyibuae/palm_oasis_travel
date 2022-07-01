import 'package:flutter/material.dart';
import 'package:tutvideo/screens/auth_screen.dart';
import 'package:tutvideo/screens/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => AuthScreen()
            //  BottomNav()
            // WelcomeBackPage()
            ));
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueAccent,
        Colors.tealAccent,
      ])),
      // BoxDecoration(
      //     // image: DecorationImage(
      //     //     image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)
      //     ),
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Opacity(
                  opacity: opacity.value,
                  child: new Image.asset('assets/logo.png')),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: RichText(
            //     text: TextSpan(
            //         style: TextStyle(color: Colors.black),
            //         children: [
            //           TextSpan(text: 'Powered by '),
            //           TextSpan(
            //               text: 'int2.io',
            //               style: TextStyle(fontWeight: FontWeight.bold))
            //         ]),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
