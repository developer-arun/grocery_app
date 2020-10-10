import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/main_fruits.dart';

import '../Components/main_menu.dart';

class FruitScreen extends StatefulWidget {
  Color primary1,primary2,primary;
  String title;
  FruitScreen(this.primary,this.primary1,this.primary2,this.title);

  @override
  _FruitScreenState createState() => _FruitScreenState(this.primary,this.primary1,this.primary2,this.title);
}

class _FruitScreenState extends State<FruitScreen> {

  Color primary1,primary2,primary;
  String title;
  _FruitScreenState(this.primary,this.primary1,this.primary2,this.title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
        body: Stack(
            children: <Widget>[
              Menumain(primary1,primary2),
              FruitsMain(primary1,primary2,title),
            ]
        )
    );
  }
}
