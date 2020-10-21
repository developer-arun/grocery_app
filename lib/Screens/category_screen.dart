import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  final String category;
  const CategoryScreen({@required this.category});
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: kColorPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
