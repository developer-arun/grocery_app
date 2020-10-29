/*
Launching screen for the app
-> Checks if user is logged in or nor
-> If logged in checks for his details in database
-> If details present, loads them
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as AUTH;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User user;  // OBJECT OF USER CLASS DEFINED BY US

  /*
  Function to check the login status of user
   */
  void checkLogin() async {
    final authUser = await AUTH.FirebaseAuth.instance.currentUser;   // OBJECT OF FIREBASE USER CLASS

    if (authUser != null) {
      // If the user is logged in, then check his details in the database
      user = await checkUserDetails(
        email: authUser.email,
        context: context,
      );

    } else {
      // If user is not logged in then redirect him to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPurple,
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            appTitle,
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

  /*
  Function to check user details in firestore database
   */
  Future checkUserDetails({String email,BuildContext context}) async {
    User user;
    FirebaseFirestore
        .instance
        .collection("Users")
        .doc(email)
        .get()
        .then((snapshot){

      if(snapshot.exists){
        // If user details are present in database then load them in UserApi class
        var data = snapshot.data();

        // TODO: ADD MORE FIELDS IN FUTURE
        UserApi userApi = UserApi.instance;
        userApi.email = data['email'];
        userApi.firstName = data['firstName'];
        userApi.lastName = data['lastName'];
        userApi.address = data['address'];
        userApi.latitude = data['latitude'];
        userApi.longitude = data['longitude'];
        userApi.orders = data['orders'];
        userApi.phoneNo = data['phoneNumber'];
        userApi.isSeller=data['isSeller'];
        print(userApi.email);

        // After successfully loading the data take the user to home screen
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        // If the details are not present in database then redirect the user to details screen
        Navigator.pushReplacementNamed(context, '/details_page');
      }
    }).catchError( (error) async {
      // Display error in case of failure in loading data
      await AlertBox.showMessageDialog(context, 'Error', 'An error occurred in loading user data\n${error.message}');
    });
    return user;
  }
}
