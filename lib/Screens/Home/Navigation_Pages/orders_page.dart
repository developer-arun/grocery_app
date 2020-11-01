import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_toggle_bar.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/my_bookings_page.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/my_subscriptions_page.dart';
import 'package:grocery_app/utilities/constants.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();

  final Widget leadingWidget;
  const OrdersPage({@required this.leadingWidget});
}

class _OrdersPageState extends State<OrdersPage> {
  int selectedTab = 0;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CustomToggleBar(
                selectedTab: 0,
                tab1Name: 'Bookings',
                tab2Name: 'Subscriptions',
                onTabChanged: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
              ),
            ),
            Expanded(
              child:
                  selectedTab == 0 ? MyBookingsPage() : MySubscriptionsPage(),
            ),
          ],
        ));
  }
}
