import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/Registration/test.dart';
import 'package:grocery_app/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void checkLogin() async {
    if(FirebaseAuth.instance.currentUser != null){
      // TODO: CHECK FOR DATA
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/home');
    }else{
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPurple,
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'SabziWaaley',
            style: TextStyle(
              color: kColorWhite,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
