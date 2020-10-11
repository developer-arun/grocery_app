import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/utilities/constants.dart';

class ClippedWidget extends StatelessWidget {

  final String text;
  const ClippedWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        padding:
        const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        color: kColorPurple,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            text,
            style: TextStyle(
              color: kColorWhite,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}