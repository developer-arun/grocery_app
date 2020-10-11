import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/screens/Registration/details_screen.dart';
import 'package:grocery_app/screens/Registration/login_screen.dart';
import 'package:grocery_app/screens/Registration/registration_screen.dart';
import 'package:grocery_app/screens/splashscreen.dart';
import 'Components/main_profile.dart';
import 'screens/fruits_screen.dart';



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
          '/home': (BuildContext context) => FruitScreen(Colors.purple[50],Colors.deepPurple[800],Colors.white,"Khana Khazana"),
          '/details_page': (BuildContext context) => DetailsScreen(),
          '/profile': (BuildContext context) => ProfileScreen(),
        }
    );
  }
}


