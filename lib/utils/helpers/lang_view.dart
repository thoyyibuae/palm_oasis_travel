import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness:
            !kIsWeb && Platform.isIOS ? Brightness.light : Brightness.dark,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'app_language'.tr(),
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            buildSwitchListTileMenuItem(
                context: context,
                image:
                    // kIsWeb
                    //     ? "http://85.17.73.115:1122/Media/Images/Logos/usa.png"
                    //     :
                    "assets/images/usa.png",
                title: 'English',
                subtitle: 'Choose language',
                locale:
                    context.supportedLocales[0] //BuildContext extension method
                ),
            buildDivider(),
            buildSwitchListTileMenuItem(
                context: context,
                image:
                    //  kIsWeb
                    //     ? "http://85.17.73.115:1122/Media/Images/Logos/uae.png"
                    //     :
                    "assets/images/uae.png",
                title: 'عربي',
                subtitle: 'اختر اللغة',
                locale: EasyLocalization.of(context)!.supportedLocales[1]),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );

  Container buildSwitchListTileMenuItem(
      {required BuildContext context,
      required String image,
      required String title,
      required String subtitle,
      required Locale locale}) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      child: ListTile(
          dense: true,
          leading:
              // kIsWeb
              //     ? SizedBox(
              //         height: 45,
              //         child: CachedImage(
              //           imageUrl: image,
              //         ),
              //       )
              //     :
              CircleAvatar(backgroundImage: AssetImage(image)),
          // isThreeLine: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () {
            log(locale.toString(), name: toString());
            context.setLocale(locale); //BuildContext extension method
            //EasyLocalization.of(context).locale = locale;
            Navigator.pop(context);
          }),
    );
  }
}
