import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class CustomToggleBar extends StatelessWidget {
  const CustomToggleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: kColorPurple.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kColorPurple,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  'My Store',
                  style: TextStyle(
                    color: kColorWhite,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  'My Orders',
                  style: TextStyle(
                    color: kColorPurple,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}