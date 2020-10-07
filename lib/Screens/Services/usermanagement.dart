import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


class UserManagement {

  storeNewUser( User, context) {
    FirebaseFirestore.instance
        .collection('/users')
        .add({
      'email': User.email,
      'uid': User.uid,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/landingpage');
    }).catchError((e) {
      print(e);
    });
  }
}