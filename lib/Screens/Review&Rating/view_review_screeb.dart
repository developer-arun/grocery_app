import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Review.dart';
import 'package:grocery_app/Screens/Review&Rating/add_review_screen.dart';
import 'package:grocery_app/utilities/constants.dart';

class ViewReviewsScreen extends StatefulWidget {
  @override
  _ViewReviewsScreenState createState() => _ViewReviewsScreenState();

  final String productID;

  const ViewReviewsScreen({this.productID});
}

class _ViewReviewsScreenState extends State<ViewReviewsScreen> {
  FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _reviews = [];
  bool _loading = true; //boolean variable to check if data is presently loading
  int _perpage = 10; //limit of documents reading in one go.
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreReviews = false;
  bool _moreProductsAvailable =
      true; //boolean variable to check if more products are available

  Future _getReviews() async {
    Query query = _firebasefirestore
        .collection("Reviews&Ratings")
        .where("productId", isEqualTo: widget.productID)
        .orderBy("reviewId")
        .limit(_perpage);

    setState(() {
      _loading = true;
    });

    QuerySnapshot querySnapshot = await query.get();
    _reviews = querySnapshot.docs;
    if (querySnapshot.docs.length > 0)
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loading = false;
    });
  }

  Future _getMoreReviews() async {
    if (_moreProductsAvailable == false) {
      print("No more reviews");
      return;
    }

    if (_gettingMoreReviews == true) {
      return;
    }
    _gettingMoreReviews = true;
    if (_gettingMoreReviews == true) {
      print("getmore called");

      Query query = _firebasefirestore
          .collection("Reviews&Ratings")
          .where("productId", isEqualTo: widget.productID)
          .orderBy("reviewId")
          .startAfter([_lastDocument.data()['reviewId']]).limit(_perpage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perpage) {
        _moreProductsAvailable = false;
      }

      _reviews.addAll(querySnapshot.docs);

      setState(() {});
      _gettingMoreReviews = false;
    }
  }

  @override
  void initState() {
    super.initState();

    _getReviews();

    _scrollController.addListener(() {
      //adding scroll listener to check if more items to be loaded on scrolling
      double _maxscroll = _scrollController.position.maxScrollExtent;
      double _currscroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      if (_maxscroll - _currscroll < _delta) {
        _getMoreReviews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Product Reviews",
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _getReviews,
              child: ListView.builder(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kColorWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kColorPurple.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _reviews[index].data()['userId'],
                            style: TextStyle(
                              color: kColorPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _reviews[index].data()['review'],
                            style: TextStyle(
                              color: kColorPurple.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '⭐ ${_reviews[index].data()['rating']}',
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: CustomButtonWidget(
              label: 'Add Review',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RatingReviewScreen(
                      productId: widget.productID,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
