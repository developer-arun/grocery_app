import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class DataDisplayWidget extends StatelessWidget {
  final String data, label;
  final Color color;

  const DataDisplayWidget({
    @required this.label,
    @required this.data,
    @required this.color,
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
            color: color,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
