import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:grocery_app/Screens/Services/usermanagement.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              child:Column(
                children: [
                  Container(
                    height:400,
                    decoration: BoxDecoration(
                        image:DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill,
                        )
                    ),

                    child:Stack(
                      children: [
                        Positioned(
                          right:40,
                          top:40,
                          width:80,
                          height:150,
                          child: Container(
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                image:AssetImage('assets/images/clock.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(

                          child: Container(


                              margin:EdgeInsets.only(top:3),
                              child:Center(
                                child:Text(
                                    "Sign up",
                                    style:TextStyle(
                                      fontFamily: 'Lemon-Regular.ttf',

                                      color:Colors.white,
                                      letterSpacing: 7.0,

                                      fontSize:80,
                                      fontWeight:FontWeight.bold,

                                    )),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child:Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:[ BoxShadow(
                                    color:Color.fromRGBO(143, 148, 251, 1),
                                    blurRadius: 15.0,
                                    offset: Offset(0,10),
                                  )]
                              ),

                              child:TextFormField(

                               decoration:InputDecoration(
                                 icon:Icon( Icons.person),
                              border:
                              InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[400])
                               ) ,

                                validator: (String value) {
                                 _email=value;
                                }
//                                  var regex ="/[^\s@]+@[^\s@]+\.[^\s@]+/";
//                                  if ( !RegExp(regex).hasMatch(value)) {
//                                    return "Not a valid email ";
//                                  }
//                                  else {
//
//                                  }
//                                },


                              )
                               ),

                                  SizedBox(height:25.0),
                                  Container(

                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:[
                                  BoxShadow(
                                    color:Color.fromRGBO(143, 148, 251, 1),
                                    blurRadius: 20.0,
                                    offset: Offset(0,10),
                                  )]
                              ),

                              child:TextFormField(
                                decoration:InputDecoration(
                                  icon: Icon(Icons.lock),
                                    suffix: Icon(Icons.visibility),
                                    border:InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ) ,
                                obscureText: true,
                                validator: (value){
                                  if(value.length<8&&value.length>15)
                                  {
                                    return("Password should have atleat 8 characters and maximum 15 characters");
                                  }
                                  else
                                  {
                                    _password=value;
                                  }
                                },
                                onSaved: (String value)
                                {
                                  _password=value;
                                },
                              ),

                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height:10),


                  SizedBox(height:10),
                  Container(
                    width: 250.0,
                    height: 50.0,
                    child:  RaisedButton(
                      color: Colors.indigoAccent,
                      child: Text('Signup',
                        style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 5.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side:BorderSide(color:Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {

                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password
                          ).then((signedInUser) {
                            UserManagement().storeNewUser(
                                signedInUser.user, context);
                          }).catchError((e) {
                            print(e);
                          });
                        }
                      }

                      ),
                    ),
                  ]
              ),
          )

          ),
              );

  }
}

