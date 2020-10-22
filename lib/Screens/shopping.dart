import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/user_api.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  _getProducts() async{
    FirebaseFirestore _firebasefirestore=FirebaseFirestore.instance;
    List <DocumentSnapshot> _products=[];
    bool _loading=false;
    Query query= _firebasefirestore.collection("Products").where("city",isEqualTo: UserApi.instance.getCity()).limit(10);
    _loading=true;
    QuerySnapshot querySnapshot=await query.get();
    _products=querySnapshot.docs;

    _loading=false;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
