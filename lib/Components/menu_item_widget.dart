import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {

  final IconData icon;
  final String label;
  final Function onPressed;
  const MenuItemWidget({@required this.label,@required this.icon,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
