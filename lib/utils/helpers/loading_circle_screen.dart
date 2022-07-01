import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../theme/basic_colors.dart';

class LoadingCircleScreen extends StatelessWidget {
  const LoadingCircleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        // decoration: BasicColors.kBackgroundGradientDecoration,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
                // backgroundColor: BasicColors.kRed,
                ),
            SizedBox(
              height: 10,
            ),
            Text(
              'pleaseWaitWhileLoading'.tr(),
              style: TextStyle(color: BasicColors.kDarkBlue),
            )
          ],
        ),
      ),
    );
  }
}
