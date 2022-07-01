import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'lang_view.dart';

class LanguageWidget extends StatelessWidget {
  final Color fontColor;
  const LanguageWidget({Key? key, this.fontColor = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LanguageView(),
                  )),
              child: Text(
                EasyLocalization.of(context)?.locale.toString() == 'en'
                    ? 'تغير لغة التطبيق'
                    : 'Change App language',
                style: TextStyle(color: fontColor),
              )),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LanguageView(),
                ));
              },
              child:
                  // kIsWeb
                  //     ? SizedBox(
                  //         height: 30,
                  //         width: 30,
                  //         child:
                  //     CachedImage(
                  //       imageUrl: context.locale.toString() == 'en'
                  //           ? 'http://85.17.73.115:1122/Media/Images/Logos/uae.png'
                  //           : 'http://85.17.73.115:1122/Media/Images/Logos/usa.png',
                  //       // width: 30,
                  //       // height: 30,
                  //     ),
                  //   )
                  // :
                  Image.asset(
                EasyLocalization.of(context)?.locale.toString() == 'en'
                    ? 'assets/images/uae.png'
                    : 'assets/images/usa.png',
                width: 30,
                height: 30,
              ))
        ],
      ),
    );
  }
}
