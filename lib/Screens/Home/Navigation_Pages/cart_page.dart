import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_bottomNavBar.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/utilities/constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Booking> book = [
    Booking(
        productname: "Pomegrenate",
        price: 200.0,
        quantity: 4.0,
        imageurl: "assets/images/pomegrenate.jpg"),
    Booking(
        productname: "Mango",
        price: 150.0,
        quantity: 5.0,
        imageurl: "assets/images/mango.jpg"),
    Booking(
        productname: "Apple",
        price: 100.0,
        quantity: 6.0,
        imageurl: "assets/images/apple.jpg"),
    Booking(
        productname: "Guavava",
        price: 60.0,
        quantity: 7.0,
        imageurl: "assets/images/guavava.jpg"),
    Booking(
        productname: "Watermelon",
        price: 200.0,
        quantity: 4.0,
        imageurl: "assets/images/watermelon.jpg"),
    Booking(
        productname: "Banana",
        price: 200.0,
        quantity: 4.0,
        imageurl: "assets/images/banana.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      height: 100.0,
                      child: ListView.builder(
                        //CREATING A LIST VIEW BUILDER
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 15.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: kColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: kColorPurple.withOpacity(0.1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      book[index].imageurl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Container(
                                                  child: Center(
                                                      child: Text(
                                            book[index].productname,
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )))),
                                          Expanded(
                                              child: Container(
                                                  child: Center(
                                                      child: Text(
                                            "Price  \$" +
                                                book[index].price.toString(),
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )))),
                                          Expanded(
                                              child: Container(
                                                  child: Center(
                                                      child: Text(
                                            book[index].quantity.toString() +
                                                "Kg",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )))),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                boxShadow: [BoxShadow(color: Colors.redAccent, blurRadius: 3.0)],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Item Select",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 25.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          "4",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 25.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          "200",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomButtonWidget(label: "Order now", onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
