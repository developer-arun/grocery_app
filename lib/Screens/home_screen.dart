import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body:Center(
        child: Container(
          child: Column(
            children: [
              Text('You are now logged in'),
              SizedBox(height: 15.0),
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.red,
                  style: BorderStyle.solid,
                  width: 3.0,

                ),
                child: Text('Log Out'),
                onPressed: (){
                  FirebaseAuth.instance.signOut().then((value) => null).catchError((e){print(e);});
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
