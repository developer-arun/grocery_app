import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/Screens/Review&Rating/review_screen.dart';
import 'package:grocery_app/Screens/Shopping/all_products_screen.dart';
import 'package:grocery_app/Screens/search_screen.dart';
import 'package:grocery_app/screens/Home/landing_screen.dart';
import 'package:grocery_app/screens/Registration/details_screen.dart';
import 'package:grocery_app/screens/Registration/login_screen.dart';
import 'package:grocery_app/screens/Registration/registration_screen.dart';
import 'package:grocery_app/screens/splashscreen.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'Screens/Store/add_item_screen.dart';


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
      theme: ThemeData.light().copyWith(
        primaryColor: kColorPurple,
        accentColor: kColorPurple,
      ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String,WidgetBuilder>{
          '/login' : (BuildContext context) => LoginScreen(),
          '/signup': (BuildContext context) => RegistrationScreen(),
          '/home': (BuildContext context) => LandingScreen(),
          '/details_page': (BuildContext context) => DetailsScreen(),
          '/search':(BuildContext context) =>SearchPage(),
          '/addItem':(BuildContext context) =>AddItem(),
          '/shop':(BuildContext context)=>AllProductsScreen(),  //CODE BADLANA H
          '/ratingreview':(BuildContext context)=>RatingReviewScreen(),
        }
    );
  }
}


