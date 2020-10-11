import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/Registration/details_screen.dart';
import 'package:grocery_app/Screens/Registration/login_screen.dart';
import 'package:grocery_app/Screens/Registration/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Screens/home_screen.dart';
import 'package:grocery_app/Screens/splashscreen.dart';
import 'package:grocery_app/Components/main_dashboard.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/fruits_screen.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Components/main_profile.dart';
import 'package:grocery_app/utilities/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String,WidgetBuilder>{
          '/login' : (BuildContext context) => LoginScreen(),
          '/signup': (BuildContext context) => RegistrationScreen(),
          '/home': (BuildContext context) => Home(),
          '/details_page': (BuildContext context) => DetailsScreen(),
        }
    );
  }
}


