import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email;
  String _password;
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
                      'Sign Up',
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
                            hintStyle: TextStyle(color: Colors.grey[400]),
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
                child: MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: kColorPurple,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    if (_email.isNotEmpty &&
                        _password.isNotEmpty &&
                        _password.length > 6) {
                      setState(() {
                        _loading = true;
                      });
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((signedInUser) {
                        FirebaseAuth.instance.currentUser
                            .sendEmailVerification()
                            .then((value) async {
                          setState(() {
                            _loading = false;
                          });
                          await AlertBox.showMessageDialog(context, 'Success',
                              'Registration successful! Please verify your email to login.');
                          Navigator.pushReplacementNamed(context, '/login');
                        }).catchError((error) {
                          setState(() {
                            _loading = false;
                          });
                          AlertBox.showMessageDialog(context, 'Error', error.message);
                        });
                      }).catchError((e) {
                        setState(() {
                          _loading = false;
                        });
                        AlertBox.showMessageDialog(context, 'Error', e.message);
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
                ),
              ),
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
