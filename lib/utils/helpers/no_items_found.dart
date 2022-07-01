import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../theme/basic_colors.dart';
import 'screen_size.dart';

class NoItemsFound extends StatelessWidget {
  const NoItemsFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenSize.height(context) / 3,
        alignment: Alignment.bottomCenter,
        child: Text('noItemsFound'.tr(),
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: BasicColors.kDarkBlue)));
  }
}
