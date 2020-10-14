import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/Screens/search_screen.dart';
import 'package:grocery_app/Store/add_item_screen.dart';
import 'package:grocery_app/screens/Home/landing_screen.dart';
import 'package:grocery_app/screens/Registration/details_screen.dart';
import 'package:grocery_app/screens/Registration/login_screen.dart';
import 'package:grocery_app/screens/Registration/registration_screen.dart';
import 'package:grocery_app/screens/splashscreen.dart';
import 'Components/main_profile.dart';


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
          '/home': (BuildContext context) => LandingScreen(),
          '/details_page': (BuildContext context) => DetailsScreen(),
          '/profile': (BuildContext context) => ProfileScreen(),
          '/search':(BuildContext context) =>SearchPage(),
          '/addItem':(BuildContext context) =>AddItem(),
        }
    );
  }
}


