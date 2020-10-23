import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/product_card.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}


class _AllProductsScreenState extends State<AllProductsScreen> {
  FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _products = [];
  bool _loading = true; //boolean variable to check if data is presently loading
  int _perpage = 15; //limit of documents reading in one go.
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable =
      true; //boolean variable to check if more products are available

  //function for initially getting the products
  _getProducts() async {
    Query query = _firebasefirestore
        .collection("Products")
        .where("city", isEqualTo: UserApi.instance.getCity())
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .orderBy("itemId")
        .limit(_perpage);

    setState(() {
      _loading = true;
    });

    QuerySnapshot querySnapshot = await query.get();
    _products = querySnapshot.docs;
    _lastDocument = querySnapshot
        .docs[querySnapshot.docs.length - 1]; //finding the last document loaded

    setState(() {
      _loading = false;
    });
  }

  //function for loading more products
  _getMoreProducts() async {
    if (_moreProductsAvailable == false) {
      print("nomore products");
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    if (_gettingMoreProducts == true) {
      print("getmore called");
      Query query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("itemId")
          .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perpage) {
        _moreProductsAvailable = false;
      }

      _products.addAll(querySnapshot.docs); //adding loaded products to the list

      setState(() {});
      _gettingMoreProducts = false;
    }
  }

  @override
  void initState() {
    super.initState();

    _getProducts();

    _scrollController.addListener(() {
      //adding scroll listener to check if more items to be loaded on scrolling
      double _maxscroll = _scrollController.position.maxScrollExtent;
      double _currscroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      if (_maxscroll - _currscroll < _delta) {
        _getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'SabziWaaley',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      body: _loading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextInputWidget(
                          hint: 'Search for something!!',
                          icon: Icons.search,
                          obscureText: false,
                          onChanged: (value){
                            // TODO: CODE
                          },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: kColorPurple,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.tune,
                          color: kColorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    child: _products.length == 0
                        ? Center(
                            child: Text("no data"),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            itemCount: _products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                child: ProductCard(
                                    product: Product(
                                      id: _products[index].data()["itemId"],
                                      name: _products[index].data()["name"],
                                      desc: _products[index].data()["description"],
                                      ownerEmail: _products[index].data()["storeId"],
                                      price: _products[index].data()["price"],
                                      quantity: _products[index].data()["quantity"],
                                      rating: _products[index].data()["rating"],
                                      reviews: _products[index].data()["reviews"],
                                      orders: _products[index].data()["orders"],
                                      imageURL: _products[index].data()["imageurl"],
                                      category: _products[index].data()["category"],
                                      timestamp: int.parse(_products[index].data()["timestamp"]),
                                      city: UserApi.instance.getCity(),
                                      country: UserApi.instance.getCountry(),
                                    ),
                                ),
                              );
                            },
                          ),
                  ),
              ),
              _gettingMoreProducts ?
              Center(
                child: Transform.scale(
                  scale: 0.5,
                  child: CircularProgressIndicator(
                  ),
                ),
              ):
              Container(),
            ],
          ),
    );
  }
}