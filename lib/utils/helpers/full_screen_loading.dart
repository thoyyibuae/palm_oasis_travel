import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  final bool loading;
  final Widget child;
  final Color fillColor;
  const FullScreenLoading({
    Key? key,
    required this.loading,
    required this.child,
    this.fillColor = const Color(0xAA9E9E9E),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: Container(
              color: fillColor,
              alignment: Alignment.center,
              child:
                  // Container(
                  //   decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 10),
                  //             blurRadius: 15,
                  //             color: Colors.black)
                  //       ],
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(15)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(25.0),
                  //     child:
                  CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              // ),
              // ),
            ),
          )
      ],
    );
  }
}
