import 'package:flutter/material.dart';
import 'package:grocery_app/Components/main_dashboard.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/fruits_screen.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/main_profile.dart';
import 'package:grocery_app/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/home",
      routes: {
        "/profile":(context)=> Profile(Colors.purple[50],kColorPurple),
        "/home" : (context) => MenuDashboard(Colors.purple[50],Colors.deepPurple[800],Colors.white,"Khana Khazana"),
        "/fruits":(context)=>FruitScreen(Colors.pink[50],Colors.pinkAccent[400],Colors.white,"Khana Khazana"),
      },
    );
  }
}

