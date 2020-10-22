/*
Registration Screen
-> Registers users with email and password
-> Sends a verification email to the address provided
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email = "";
  String _password = "";
  bool _passHidden = true;
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClippedWidget(
                text: 'Sign Up',
              ),
              Form(
                key: _formKey, //ENTERING DETAILS FOR SIGNUP
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextInputWidget(
                        hint: 'Enter email',
                        icon: Icons.person,
                        obscureText: false,
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: kColorPurple.withOpacity(0.1),
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: kColorPurple,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_passHidden) {
                                      _passHidden = false;
                                    } else {
                                      _passHidden = true;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: kColorPurple,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          obscureText: _passHidden,
                          onChanged: (String value) {
                            _password = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: CustomButtonWidget(
                    label: 'Sign Up',
                    onPressed: () async {
                      if (_email.isNotEmpty &&
                          _password.isNotEmpty &&
                          _password.length > 6) {
                        setState(() {
                          _loading = true;
                        });
                        FirebaseAuth
                            .instance //CREATING USER WITH EMAIL AND PASSWORD
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((signedInUser) {
                          FirebaseAuth.instance.currentUser
                              .sendEmailVerification()
                              .then((value) async {
                            setState(() {
                              _loading = false;
                            });
                            await AlertBox.showMessageDialog(
                                context,
                                'Success', //SUCCESSFULL SIGNUP
                                'Registration successful! Please verify your email to login.');
                            Navigator.pushReplacementNamed(context, '/login');
                          }).catchError((error) {
                            setState(() {
                              _loading = false;
                            });
                            AlertBox.showMessageDialog(
                                context, 'Error', error.message);
                          });
                        }).catchError((e) {
                          setState(() {
                            _loading = false;
                          });
                          AlertBox.showMessageDialog(
                              context, 'Error', e.message);
                        });
                      } else {
                        if (_password.isEmpty || _email.isEmpty)
                          AlertBox.showMessageDialog(context, 'Error',
                              'Please fill up all the required fields!');
                        else
                          AlertBox.showMessageDialog(context, 'Error',
                              'Password length must be greater than 6.');
                      }
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: kColorPurple,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
