import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorPurple.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}