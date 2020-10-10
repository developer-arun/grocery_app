import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/main_dashboard.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/main_menu.dart';
import 'package:grocery_app/screens/fruits_screen.dart';

class MenuDashboard extends StatefulWidget{

  Color primary1,primary2,primary;
  String title;
  MenuDashboard(this.primary,this.primary1,this.primary2,this.title);

  @override
  _MenuDashboard createState() => _MenuDashboard(this.primary,this.primary1,this.primary2,this.title);
}

class _MenuDashboard extends State<MenuDashboard> {
  Color primary1,primary2,primary;
  String title;
  _MenuDashboard(this.primary,this.primary1,this.primary2,this.title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : primary,
      body: Stack(
        children: <Widget>[
          Menumain(primary1,primary2),
          Dasboardmain(primary1,primary2,title),
        ],
      ),
    );
  }
}