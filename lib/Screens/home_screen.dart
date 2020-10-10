import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/user_api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserApi userApi = UserApi.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(userApi.email),
              Text(userApi.email),
              SizedBox(height: 15.0),
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.red,
                  style: BorderStyle.solid,
                  width: 3.0,
                ),
                child: Text('Log Out'),
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => null)
                      .catchError((e) {
                    print(e);
                  });
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
