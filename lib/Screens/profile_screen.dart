import 'package:flutter/material.dart';
import 'package:grocery_app/Components/main_menu.dart';
import 'package:grocery_app/Components/main_profile.dart';

class Profile extends StatefulWidget {
  Color primary1,primary2;
  Profile(this.primary1,this.primary2);

  @override
  _ProfileState createState() => _ProfileState(primary1,primary2);
}

class _ProfileState extends State<Profile> {
  Color primary1,primary2;

  _ProfileState(this.primary1,this.primary2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary1,
        body: Stack(
            children: <Widget>[
              Menumain(primary2,primary1),
              ProfileScreen()
            ]
        )
    );;
  }
}
