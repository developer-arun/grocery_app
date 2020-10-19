import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kColorWhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          "SabziWaaley",
          style: TextStyle(
            fontSize: 24,
            color: kColorPurple,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Form(
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  TextInputWidget(
                    hint: "Order something refreshing!!!",
                    icon: Icons.search,
                    obscureText: false,
                    onChanged: (value) {
                      // _email = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          


        ],
      ),
    );
  }
}
