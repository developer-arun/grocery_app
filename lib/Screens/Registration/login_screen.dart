import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/clipped_widget.dart';
import 'package:grocery_app/components/custom_button_widget.dart';
import 'package:grocery_app/components/text_input_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
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
              ClippedWidget(
                text: 'Login',
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextInputWidget(
                        hint: "Enter email",
                        icon: Icons.person,
                        obscureText: false,
                        onChanged: (value) {
                          _email = value;
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
                  onPressed: (){
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
                )
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
