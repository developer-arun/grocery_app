import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as AUTH;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/utilities/alert_box.dart';
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
      user = await checkUserDetails(
        email: authUser.email,
        context: context,
      );
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

  Future checkUserDetails({String email,BuildContext context}) async {
    User user;
    FirebaseFirestore
        .instance
        .collection("Users")
        .doc(email)
        .get()
        .then((snapshot){
      if(snapshot.exists){
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        Navigator.pushReplacementNamed(context, '/details_page');
      }
    }).catchError( (error) async {
      await AlertBox.showMessageDialog(context, 'Error', 'An error occurred in loading user data\n${error.message}');
    });
    return user;
  }
}
