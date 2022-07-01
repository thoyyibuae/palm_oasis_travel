import 'package:flutter/material.dart' hide showMenu;
import 'package:flutter/material.dart' as material show showMenu;

/// A mixin to provide convenience methods to record a tap position and show a popup menu.
mixin CustomPopupMenu<T extends StatefulWidget> on State<T> {
  // Offset? _tapPosition;

  // /// Pass this method to an onTapDown parameter to record the tap position.
  // void storePosition(TapDownDetails details) {
  //   _tapPosition = details.globalPosition;
  // }

  /// Use this method to show the menu.
  Future<T?> showMenu<T>({
    required BuildContext context,
    required List<PopupMenuEntry<T>> items,
    T? initialValue,
    double? elevation,
    String? semanticLabel,
    ShapeBorder? shape,
    Color? color,
    required Offset? tapPosition,
    // bool captureInheritedThemes = true,
    bool useRootNavigator = false,
  }) {
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    return material.showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition?.dx ?? 0,
        tapPosition?.dy ?? 0,
        overlay.size.width - (tapPosition?.dx ?? 0),
        overlay.size.height - (tapPosition?.dy ?? 0),
      ),
      items: items,
      initialValue: initialValue,
      elevation: elevation,
      semanticLabel: semanticLabel,
      shape: shape,
      color: color,
      // captureInheritedThemes: captureInheritedThemes,
      useRootNavigator: useRootNavigator,
    );
  }
}
