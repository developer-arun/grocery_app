import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Screens/Shopping/product_screen.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _products = [];
  bool _loading = true; //boolean variable to check if data is presently loading
  int _perPage = 15; //limit of documents reading in one go.
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable =
      true; //boolean variable to check if more products are available

  //function for initially getting the products
  Future _getProducts(String queryString) async {
    Query query = db
        .collection("SearchQueries")
        .where("city", isEqualTo: UserApi.instance.getCity())
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .where("nameCase", arrayContains: queryString)
        .orderBy("docId")
        .limit(_perPage);

    setState(() {
      _loading = true;
    });

    QuerySnapshot querySnapshot = await query.get();
    _products = querySnapshot.docs;

    if (querySnapshot.docs.length > 0)
      _lastDocument = querySnapshot.docs[
          querySnapshot.docs.length - 1]; //finding the last document loaded

    setState(() {
      _loading = false;
    });
  }

  //function for loading more products
  Future _getMoreProducts(String queryString) async {
    if (_moreProductsAvailable == false) {
      print("No more products");
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    if (_gettingMoreProducts == true) {
      print("getmore called");
      Query query = db
          .collection("SearchQueries")
          .where("city", isEqualTo: UserApi.instance.getCity())
          .where("country", isEqualTo: UserApi.instance.getCountry())
          .where("nameCase", arrayContains: queryString.toLowerCase())
          .orderBy("docId")
          .startAfter([_lastDocument.data()["itemId"]]).limit(_perPage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perPage) {
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

    _scrollController.addListener(() {
      //adding scroll listener to check if more items to be loaded on scrolling
      double _maxScroll = _scrollController.position.maxScrollExtent;
      double _currScroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      if (_maxScroll - _currScroll < _delta) {
        _getMoreProducts(_controller.text.toLowerCase());
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
            appTitle,
            style: TextStyle(
              color: kColorPurple,
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextInputWidget(
                hint: 'Search for something!!',
                icon: Icons.search,
                obscureText: false,
                controller: _controller,
                onChanged: (value) {
                  _getProducts(value);
                },
              ),
            ),
            Expanded(
              child: Container(
                child: _loading == true
                    ? (_controller.text.isEmpty
                        ? Center(
                            child: Text(
                              'Nothing to display',
                              style: TextStyle(
                                  color: kColorPurple.withOpacity(0.4),
                                  fontSize: 20),
                            ),
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ))
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: _products.length == 0
                                  ? Center(
                                      child: Text(
                                        'No matches found',
                                        style: TextStyle(
                                            color:
                                                kColorPurple.withOpacity(0.4),
                                            fontSize: 20),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      controller: _scrollController,
                                      itemCount: _products.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            _products[index].data()['name'],
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductScreen(
                                                  productId: _products[index]
                                                      .data()['docId'],
                                                  product: null,
                                                  fromCart: false,
                                                ),
                                              ),
                                            );
                                          },
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
              ),
            ),
          ],
        ));
  }
}
