import 'package:flutter/material.dart';
import 'package:grocery_app/Components/booking_card.dart';
import 'package:grocery_app/Components/menu_item_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/previous_orders_page.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();

  final Widget leadingWidget;

  const OrdersPage({@required this.leadingWidget});
}

class _OrdersPageState extends State<OrdersPage> {
  List<Widget> ordersToDisplay = [];

  void getOrders() async {
    List<Booking> bookings = await DatabaseServices.getBooking();
    for (Booking booking in bookings) {
      ordersToDisplay.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: BookingCard(
            booking: booking,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          'My Orders',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: ordersToDisplay,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreviousOrdersPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kColorPurple,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  'Previous Orders',
                  style: TextStyle(
                    color: kColorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
