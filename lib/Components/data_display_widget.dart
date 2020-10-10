import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class DataDisplayWidget extends StatelessWidget {
  final String data, label;

  const DataDisplayWidget({
    @required this.label,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kColorPurple,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: TextStyle(
            color: kColorPurple,
          ),
        ),
      ],
    );
  }
}
