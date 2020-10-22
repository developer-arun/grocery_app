//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/user_api.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  FirebaseFirestore _firebasefirestore=FirebaseFirestore.instance;
  List <QueryDocumentSnapshot> _products=[];
  bool _loading=true;                                            //boolean variable to check if data is presently loading
  int _perpage=20;                                                //limit of documents reading in one go.
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController=ScrollController();
  bool _gettingMoreProducts=false;
  bool _moreProductsAvailable=true;                                    //boolean variable to check if more products are available

//function for initially getting the products
  _getProducts() async{
    Query query= _firebasefirestore.collection("Products").where("city",isEqualTo: UserApi.instance.getCity()).limit(_perpage);
    setState(() {
      _loading=true;
    });
    QuerySnapshot querySnapshot=await query.get();
    _products=querySnapshot.docs;
    _lastDocument=querySnapshot.docs[querySnapshot.docs.length-1];  //finding the last document loaded
    setState(() {
      _loading=false;
    });
  }

  //function for loading more products
  _getMoreProducts() async{
    _gettingMoreProducts=true;
    if(_moreProductsAvailable==false)
      {
        print("nomore products");
        return;
      }
    if(_gettingMoreProducts==true)
      {
        return;
      }

    print("getmore called");
    Query query= _firebasefirestore.collection("Products").
    where("city",isEqualTo: UserApi.instance.getCity()).
    startAfter([_lastDocument.data()["name"]]).
    limit(_perpage);

    QuerySnapshot querySnapshot=await query.get();
    _lastDocument=querySnapshot.docs[querySnapshot.docs.length-1];
    if(querySnapshot.docs.length<_perpage)
      _moreProductsAvailable=false;

    _products.addAll(querySnapshot.docs);                      //adding loaded products to the list

    setState(() {
    });
    _gettingMoreProducts=false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts();
    _scrollController.addListener(() {                                    //adding scroll listener to check if more items to be loaded on scrolling
      double _maxscroll=_scrollController.position.maxScrollExtent;
      double _currscroll=_scrollController.position.pixels;
      double _delta=MediaQuery.of(context).size.height*0.25;

      if(_maxscroll-_currscroll<_delta)
        {
          _getMoreProducts();
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading==true?Container(
        child: Text('loading'),
      ):Container(
        child: _products.length==0?Center(
          child: Text("no data"),
        ):ListView.builder(
          controller: _scrollController,
          itemCount: _products.length,
            itemBuilder: (BuildContext context,int index){
          return ListTile(
            title: Text(_products[index].data()["name"]),
          );
      }),
      ),
    );
  }
}
