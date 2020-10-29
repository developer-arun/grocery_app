import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class ViewReviewsScreen extends StatefulWidget {
  @override
  _ViewReviewsScreenState createState() => _ViewReviewsScreenState();
}

class _ViewReviewsScreenState extends State<ViewReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: kColorPurple,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              appTitle,
              style: TextStyle(
                color: kColorPurple,
                fontSize: 24,
              ),
        ),
      ),
      backgroundColor: Colors.white,

      );
  }
}
