import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _email;
  String _password;
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  color: kColorPurple,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: kColorWhite,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
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
                              Icons.person,
                              color: kColorPurple,
                            ),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
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
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          obscureText: true,
                          onChanged: (value) {
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
                child: RaisedButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: kColorPurple,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (_email.isNotEmpty && _password.isNotEmpty) {
                      setState(() {
                        _loading = true;
                      });
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((user) {
                        if (FirebaseAuth.instance.currentUser.emailVerified) {
                          // USER IS VERIFIED
                          setState(() {
                            _loading = false;
                          });
                          Navigator.pushReplacementNamed(context, '/home');
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
                        AlertBox.showMessageDialog(context, 'Error', e.message);
                      });
                    } else {
                      AlertBox.showMessageDialog(context, 'Error',
                          'Please fill up all the required fields.');
                    }
                  },
                ),
              ),
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
}
