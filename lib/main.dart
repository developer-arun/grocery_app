import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/Registration/details_screen.dart';
import 'package:grocery_app/Screens/Registration/login_screen.dart';
import 'package:grocery_app/Screens/Registration/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/grocery_app/lib/Screens/home_screen.dart';
import 'package:grocery_app/Screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
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
