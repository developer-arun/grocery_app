import 'package:flutter/material.dart';

import 'package:grocery/login.dart';
import 'package:grocery/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery/home.dart';

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


        home:Login(),
        routes: <String,WidgetBuilder>{
          '/landingpage':(BuildContext context)=>MyApp(),
          '/signup':(BuildContext context)=>Signup(),
          '/home':(BuildContext context)=>Home(),

        }


    );
  }
}
