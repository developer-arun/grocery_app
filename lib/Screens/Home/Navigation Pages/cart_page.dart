import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cart Page',
        ),
      ),
    );
  }
}

class Booking{
  double fromLatitude;
  double fromLongitude;


}