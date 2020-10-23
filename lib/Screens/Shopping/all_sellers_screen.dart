import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/product_card.dart';
import 'package:grocery_app/Components/store_card.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class AllSellersScreen extends StatefulWidget {
  @override
  _AllSellersScreenState createState() => _AllSellersScreenState();
}

class _AllSellersScreenState extends State<AllSellersScreen> {
  // Instance of firestore database
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // List of sellers to be displayed
  List<QueryDocumentSnapshot> _sellers = [];

  // variable to check if data is currently loading
  bool _loading = true;

  // Number of sellers loaded in one batch
  int _perPage = 15;

  // Variable to keep a record of last data item fetched from database
  DocumentSnapshot _lastDocument;

  // Scroll controller which will be used for checking overscroll and then load more data
  ScrollController _scrollController = ScrollController();

  // Variable to check if more products are being loaded or not
  bool _gettingMoreSellers = false;

  // Variable to check if more data is available in database
  bool _moreSellersAvailable = true;

  //function for initially getting the products
  void _getSellers() async {
    Query query = db
        .collection("Sellers")
        .where("city", isEqualTo: UserApi.instance.getCity())
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .orderBy("ownerEmail")
        .limit(_perPage);

    setState(() {
      _loading = true;
    });

    QuerySnapshot querySnapshot = await query.get();
    _sellers = querySnapshot.docs;

    // Last document loaded
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loading = false;
    });
  }

  /*
  Function to load more data from database on overscroll
   */
  void _getMoreSellers() async {
    // Checking if more data is available in database or not
    if (_moreSellersAvailable == false) {
      return;
    }

    // If more data is already being loaded
    if (_gettingMoreSellers == true) {
      return;
    }

    // Loading more data
    _gettingMoreSellers = true;
    if (_gettingMoreSellers == true) {
      Query query = db
          .collection("Sellers")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .orderBy("ownerEmail")
          .startAfter([_lastDocument.data()["ownerEmail"]]).limit(_perPage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perPage) {
        _moreSellersAvailable = false;
      }

      // Adding loaded sellers to the list
      _sellers.addAll(querySnapshot.docs);

      setState(() {});
      _gettingMoreSellers = false;
    }

  }

  @override
  void initState() {
    super.initState();

    _getSellers();

    _scrollController.addListener(() {
      //adding scroll listener to check if more items are to be loaded on scrolling
      double _maxScroll = _scrollController.position.maxScrollExtent;
      double _currentScroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      // Loading more items on overscroll
      if (_maxScroll - _currentScroll < _delta) {
        _getMoreSellers();
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
                          hint: 'Search for stores, sellers',
                          icon: Icons.search,
                          obscureText: false,
                          onChanged: (value) {
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
                    child: _sellers.length == 0
                        ? Center(
                            child: Text("No data"),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            itemCount: _sellers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StoreCard(
                                store: Store(
                                  name: _sellers[index].data()["name"],
                                  ownerEmail: _sellers[index].data()["ownerEmail"],
                                  ownerName: _sellers[index].data()["ownerName"],
                                  ownerContact: _sellers[index].data()["ownerContact"],
                                  rating: _sellers[index].data()["rating"],
                                  reviews: _sellers[index].data()["reviews"],
                                  address: _sellers[index].data()["address"],
                                  latitude: _sellers[index].data()["latitude"],
                                  longitude: _sellers[index].data()["longitude"],
                                  orders: _sellers[index].data()["orders"],
                                  city: UserApi.instance.getCity(),
                                  country: UserApi.instance.getCountry(),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                _gettingMoreSellers
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
