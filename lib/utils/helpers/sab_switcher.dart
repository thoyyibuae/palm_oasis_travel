import 'package:flutter/material.dart';

class SABSwitcher extends StatefulWidget {
  final Widget fromChild;
  final Widget toChild;

  const SABSwitcher({
    Key? key,
    required this.fromChild,
    required this.toChild,
  }) : super(key: key);
  @override
  _SABSwitcherState createState() {
    return new _SABSwitcherState();
  }
}

class _SABSwitcherState extends State<SABSwitcher> {
  ScrollPosition? _position;
  bool _visible = false;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    if (mounted) {
      _position = Scrollable.of(context)?.position;
      _position?.addListener(_positionListener);
      _positionListener();
    }
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    print(settings?.minExtent);
    bool visible =
        settings == null || settings.currentExtent > settings.minExtent + 10;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _visible ? widget.fromChild : widget.toChild,
    );
  }
}
