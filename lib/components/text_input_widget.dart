import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();

  final String hint;
  final IconData icon;
  final bool obscureText;
  final Function onChanged,onTap;
  final TextEditingController controller;
  final TextInputType textInputType;
  const TextInputWidget({
    @required this.hint,
    @required this.icon,
    @required this.obscureText,
    @required this.onChanged,
    this.controller,
    this.textInputType,
    this.onTap,
  });

}

class _TextInputWidgetState extends State<TextInputWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kColorPurple.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.controller,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kColorPurple,
          ),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
      ),
    );
  }
}

