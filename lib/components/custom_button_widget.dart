import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class CustomButtonWidget extends StatelessWidget {

  final String label;
  final Function onPressed;
  const CustomButtonWidget({@required this.label,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding:
      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      color: kColorPurple,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
    );
  }
}
