import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/utilities/alert_box.dart';

class UserManagement {
  
  static Future<User> checkUserDetails({String email,BuildContext context}) async {
    User user;
    FirebaseFirestore
        .instance
        .collection("Users")
        .doc(email)
        .get()
        .then((snapshot){
    if(snapshot.exists){
      print("Hai");
    }
    }).catchError( (error) {
        AlertBox.showMessageDialog(context, 'Error', 'An error occurred in loading user data\n${error.message}');
    });
    return user;
  }

}