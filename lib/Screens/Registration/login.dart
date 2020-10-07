import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                            "Login",
                        style:TextStyle(
                          fontFamily: 'Lemon-Regular.ttf',

                          color:Colors.white,
                          letterSpacing: 10.0,

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
                                      color:Color.fromRGBO(143, 148, 251, 3),
                                      blurRadius: 8.0,
                                      offset: Offset(0,8),
                                    )]
                                ),

                          child:TextFormField(
                            decoration:InputDecoration(
                              icon: Icon(Icons.person),
                              border:InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ) ,
                            validator: (value){
                              _email=value;
//                              if(!RegExp("^[a-z0-9]+[._]?[a-z0-9]+[@]+[.]{2,3}").hasMatch(value))
//                              {
//                                return("Not a valid Email");
//                              }
//                              else
//                                {
//
//                                }
                            },
                          ),
                              ),
                              SizedBox(height:25.0),
                              Container(

                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow:[ BoxShadow(
                                      color:Color.fromRGBO(143, 148, 251, 1),
                                      blurRadius: 8.0,
                                      offset: Offset(0,8),
                                    )]
                                ),
                                child:TextFormField(
                                  decoration:InputDecoration(
                                    icon: Icon(Icons.lock),

                                      border:InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ) ,
                                  obscureText: true,
                                  validator: (value){
                                    if((value.length<8||value.length>15))
                                    {
                                      return("Password should have atleast 8 characters and maximum 15 characters");
                                    }
                                    else
                                    {
                                      _password=value;
                                    }

                                  },
                                ),

                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: GestureDetector(
                                  onTap:(){},

                                  child: Text("Forgot Password?",
                                  style:TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              )
                            ],
                          )

                            ],
                          )
                        ),
                ),
                SizedBox(height:10),
                Container(
                  width: 250.0,
                  height: 50.0,
                  child:  RaisedButton(
                    color: Colors.indigoAccent,
                    child: Text('Login',
                      style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 5.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:BorderSide(color:Colors.white),
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate())
                        {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          ).then((user) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }).catchError((e){
                            print (e);
                          });
                        }

                    },
                  ),
                ),
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
                    onPressed: (){
                      Navigator.pushNamed(context,'/signup');
                    },
                  ),
                ),
              ],
            )
        ),
      )
    );
  }
}

