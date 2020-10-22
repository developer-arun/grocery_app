/*
Login Screen
-> Checks that only verified user can login
-> Loads the details of user from firestore using email
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";

  // This will display a progress indicator when set to true
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: kColorWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClippedWidget(
                text: 'Login',
              ),
              Form(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextInputWidget(
                        hint: "Enter email",
                        icon: Icons.person,
                        obscureText: false,
                        onChanged: (value) {
                          String trim = value;
                          _email = trim.trim();
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextInputWidget(
                        hint: 'Enter password',
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: CustomButtonWidget(
                    label: 'Login',
                    onPressed: () {
                      if (_email.isNotEmpty && _password.isNotEmpty) {
                        //CHECKING IF EMAIL IS EMPTY
                        setState(() {
                          _loading = true;
                        });
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                //SIGNING IN WITH EMAIL AND PASSWORD
                                email: _email,
                                password: _password)
                            .then((user) async {
                          if (FirebaseAuth.instance.currentUser.emailVerified) {
                            //CHECKING IF EMAIL IS VERIFIED
                            // USER IS VERIFIED
                            await checkUserDetails(
                              email: _email,
                              context: context,
                            );
                          } else {
                            // USER NOT VERIFIED
                            setState(() {
                              _loading = false;
                            });
                            AlertBox.showMessageDialog(context, 'Error',
                                'Please verify your email first.');
                          }
                        }).catchError((e) {
                          setState(() {
                            _loading = false;
                          });
                          AlertBox.showMessageDialog(
                              context, 'Error', e.message);
                        });
                      } else {
                        AlertBox.showMessageDialog(context, 'Error',
                            'Please fill up all the required fields.');
                      }
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: FlatButton(
                  child: Text(
                    'Don\'t have an account? Register Now',
                    style: TextStyle(
                      color: kColorPurple,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /*
  Function to check user's details in database
   */
  Future checkUserDetails({String email, BuildContext context}) async {
    //CHECKING USER DETAILS

    FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        // User details present in database, load them in UserApi class
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

        // After successfully loading the details, move to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // If details are not present move to details screen
        Navigator.pushReplacementNamed(context, '/details_page');
      }
    }).catchError((error) async {
      // Display error in case of failure in loading data
      await AlertBox.showMessageDialog(context, 'Error',
          'An error occurred in loading user data\n${error.message}');
    });
  }
}
