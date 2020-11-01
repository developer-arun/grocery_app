import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/product_card.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/cart_page.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:toast/toast.dart';

import '../search_screen.dart';

enum FilterBy { RatingLow, RatingHigh, PriceLow, PriceHigh, Default }

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _products = [];
  bool _loading = true; //boolean variable to check if data is presently loading
  int _perpage = 10; //limit of documents reading in one go.
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable =
      true; //boolean variable to check if more products are available

  FilterBy _filterBy = FilterBy.Default;
  //function for initially getting the products
  _getProducts() async {
    Query query;

    if (_filterBy == FilterBy.PriceHigh) {
      query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("price",descending: true)
          .limit(_perpage);
    } else if (_filterBy == FilterBy.PriceLow) {
      query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("price",descending: false)
          .limit(_perpage);
    } else if (_filterBy == FilterBy.RatingHigh) {
      query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("rating",descending: true)
          .limit(_perpage);
    } else if (_filterBy == FilterBy.RatingLow) {
      query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("rating",descending: false)
          .limit(_perpage);
    } else {
      query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("itemId")
          .limit(_perpage);
    }

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
      Toast.show('No more products', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    if (_gettingMoreProducts == true) {
      Toast.show('Loading more products', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      Query query = _firebasefirestore
          .collection("Products")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("itemId")
          .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);

      if (_filterBy == FilterBy.PriceHigh) {
        query = _firebasefirestore
            .collection("Products")
            .where("city", isEqualTo: UserApi.instance.getCity())
            .where("country", isEqualTo: UserApi.instance.getCountry())
            .orderBy("price",descending: true)
            .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);
      } else if (_filterBy == FilterBy.PriceLow) {
        query = _firebasefirestore
            .collection("Products")
            .where("city", isEqualTo: UserApi.instance.getCity())
            .where("country", isEqualTo: UserApi.instance.getCountry())
            .orderBy("price",descending: false)
            .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);
      } else if (_filterBy == FilterBy.RatingHigh) {
        query = _firebasefirestore
            .collection("Products")
            .where("city", isEqualTo: UserApi.instance.getCity())
            .where("country", isEqualTo: UserApi.instance.getCountry())
            .orderBy("rating",descending: true)
            .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);
      } else if (_filterBy == FilterBy.RatingLow) {
        query = _firebasefirestore
            .collection("Products")
            .where("city", isEqualTo: UserApi.instance.getCity())
            .where("country", isEqualTo: UserApi.instance.getCountry())
            .orderBy("rating",descending: false)
            .startAfter([_lastDocument.data()["itemId"]]).limit(_perpage);
      }


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

      if (_maxscroll - _currscroll < _delta &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: kColorPurple,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: kColorPurple.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: kColorPurple,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Order something refreshing!!',
                                    style: TextStyle(
                                      color: kColorPurple.withOpacity(0.3),
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          FilterBy filter = FilterBy.Default;
                          await showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        Text(
                                          'Apply Filters',
                                          style: TextStyle(
                                            color: kColorPurple,
                                            fontSize: 30,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: kColorPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 0),
                                            child: Text(
                                              'Rating',
                                              style: TextStyle(
                                                color: kColorPurple,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceEvenly,
                                              children: [
                                                CustomButtonWidget(
                                                  label: 'Low first',
                                                  onPressed: () {
                                                    filter = FilterBy.RatingLow;
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CustomButtonWidget(
                                                  label: 'High first',
                                                  onPressed: () {
                                                    filter =
                                                        FilterBy.RatingHigh;
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 0),
                                            child: Text(
                                              'Price',
                                              style: TextStyle(
                                                color: kColorPurple,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceEvenly,
                                              children: [
                                                CustomButtonWidget(
                                                  label: 'Low first',
                                                  onPressed: () {
                                                    filter = FilterBy.PriceLow;
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CustomButtonWidget(
                                                  label: 'High first',
                                                  onPressed: () {
                                                    filter = FilterBy.PriceHigh;
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          if(_filterBy != filter){
                            _filterBy = filter;
                            _getProducts();
                          }
                        },
                        child: Container(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: ProductCard(
                                  product: Product(
                                    id: _products[index].data()["itemId"],
                                    name: _products[index].data()["name"],
                                    desc:
                                        _products[index].data()["description"],
                                    ownerEmail:
                                        _products[index].data()["storeId"],
                                    price: _products[index].data()["price"],
                                    quantity:
                                        _products[index].data()["quantity"],
                                    rating:
                                        _products[index].data()["rating"] * 1.0,
                                    reviews: _products[index].data()["reviews"],
                                    orders: _products[index].data()["orders"],
                                    imageURL:
                                        _products[index].data()["imageurl"],
                                    category:
                                        _products[index].data()["category"],
                                    timestamp: int.parse(
                                        _products[index].data()["timestamp"]),
                                    city: UserApi.instance.getCity(),
                                    country: UserApi.instance.getCountry(),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                _gettingMoreProducts
                    ? Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
