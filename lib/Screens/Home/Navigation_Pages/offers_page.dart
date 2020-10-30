import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();

  final Widget leadingWidget;
  const OffersPage({@required this.leadingWidget});
}

class _OffersPageState extends State<OffersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          'My Offers',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
