import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_bottomNavBar.dart';

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
      bottomNavigationBar: CustomBtmNavBAR(Colors.pink,Colors.purple[700]),
    );
  }
}
