import 'package:firebase_auth/firebase_auth.dart' as AUTH;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/Services/user_management.dart';
import 'package:grocery_app/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User user;  // OBJECT OF USER CLASS DEFINED BY US

  void checkLogin() async {
    final authUser = await AUTH.FirebaseAuth.instance.currentUser;   // OBJECT OF FIREBASE USER CLASS
    if (authUser != null) {
      user = await UserManagement.checkUserDetails(
        email: authUser.email,
        context: context,
      );
      if(user != null){
        // TODO:LOAD USER DATA
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        Navigator.pushReplacementNamed(context, '/details_page');
      }
    } else {
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
