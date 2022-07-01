import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../theme/basic_colors.dart';
import 'responsive.dart';

class BottomActionButton extends StatelessWidget {
  final String? label;
  final EdgeInsets padding;
  final void Function()? onPressed;
  final Widget? child;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final String? tooltip;
  const BottomActionButton({
    Key? key,
    this.label,
    this.padding = const EdgeInsets.all(0),
    required this.onPressed,
    this.color = BasicColors.kDarkBlue,
    this.borderRadius = BorderRadius.zero,
    this.child,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: 50,
      child: (tooltip != null)
          ? Tooltip(message: tooltip!.tr(), child: buildButton(context))
          : buildButton(context),
    );
  }

  FlatButton buildButton(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      // .vertical(top: Radius.circular(18))),
      color: color, //product.color,
      onPressed: onPressed,
      child: child ??
          (label == null
              ? SizedBox.shrink()
              : Text(
                  label?.tr().toUpperCase() ?? "",
                  style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ? 14 : 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
    );
  }
}
