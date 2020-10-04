import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/menumain.dart';

class FruitScreen extends StatefulWidget {
  @override
  _FruitScreenState createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  Color sidebarBakgrndclr=Colors.deepPurple[700];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sidebarBakgrndclr,
      body: Stack(
        children: <Widget>[
          Menumain(),

        ],
      ),
    );
  }
}
