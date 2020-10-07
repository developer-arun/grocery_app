import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/dasboardmain.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/menumain.dart';

class MenuDashboard extends StatefulWidget{
  @override
  _MenuDashboard createState() => _MenuDashboard();
}

class _MenuDashboard extends State<MenuDashboard> {
  Color sidebarBakgrndclr=Colors.deepPurple[700];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sidebarBakgrndclr,
      body: Stack(
        children: <Widget>[
          Menumain(),
          Dasboardmain(),
        ],
      ),
    );
  }
}