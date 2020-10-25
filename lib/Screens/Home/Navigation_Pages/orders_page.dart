import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/booking_status.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();

  final Widget leadingWidget;
  const OrdersPage({@required this.leadingWidget});
}

class _OrdersPageState extends State<OrdersPage> {
  // Instance of firestore database
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // List of booking to be displayed
  List<QueryDocumentSnapshot> _booking = [];

  // variable to check if data is currently loading
  bool _loading = true;

  // Number of sellers loaded in one batch
  int _perPage = 15;

  // Variable to keep a record of last data item fetched from database
  DocumentSnapshot _lastDocument;

  // Scroll controller which will be used for checking overscroll and then load more data
  ScrollController _scrollController = ScrollController();

  // Variable to check if more products are being loaded or not
  bool _gettingMoreBookings = false;

  // Variable to check if more data is available in database
  bool _moreBookingAvailable = true;

  //function for initially getting the products
  void _getBooking() async {
    Query query = db
        .collection("Booking")
        .where("buyerEmail", isEqualTo: UserApi.instance.email)
        .where("status", isEqualTo: BookingStatus.DELIVERED.toString())
        .orderBy("timestamp")
        .limit(_perPage);

    setState(() {
      _loading = true;
    });

    QuerySnapshot querySnapshot = await query.get();
    _booking = querySnapshot.docs;

    // Last document loaded
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loading = false;
    });
  }

  /*
  Function to load more data from database on overscroll
   */
  void _getMoreBooking() async {
    // Checking if more data is available in database or not
    if (_moreBookingAvailable == false) {
      return;
    }

    // If more data is already being loaded
    if (_gettingMoreBookings == true) {
      return;
    }

    // Loading more data
    _gettingMoreBookings = true;
    if (_gettingMoreBookings == true) {
      Query query = db
          .collection("Bookings")
          .where("buyerEmail", isEqualTo: UserApi.instance.email)
          .where("status", isEqualTo: BookingStatus.DELIVERED.toString())
          .orderBy("timestamp",descending: true)
          .startAfter([_lastDocument.data()["timestamp"]]).limit(_perPage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perPage) {
        _moreBookingAvailable = false;
      }

      // Adding loaded sellers to the list
      _booking.addAll(querySnapshot.docs);

      setState(() {});
      _gettingMoreBookings = false;
    }

  }

  @override
  void initState() {
    super.initState();

    _getBooking();

    _scrollController.addListener(() {
      //adding scroll listener to check if more items are to be loaded on scrolling
      double _maxScroll = _scrollController.position.maxScrollExtent;
      double _currentScroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      // Loading more items on overscroll
      if (_maxScroll - _currentScroll < _delta) {
        _getMoreBooking();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Orders Page',
        ),
      ),
    );
  }
}
