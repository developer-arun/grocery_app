import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/custom_toggle_bar.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Screens/Store/pending_bookings_screen.dart';
import 'package:grocery_app/Screens/Store/pending_subscriptions_screen.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/task_status.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StoreNotificationsScreen extends StatefulWidget {
  @override
  _StoreNotificationsScreenState createState() =>
      _StoreNotificationsScreenState();
}

class _StoreNotificationsScreenState extends State<StoreNotificationsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 26,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomToggleBar(
              selectedTab: selectedTab,
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
            child: selectedTab == 0
                ? PendingBookingsScreen()
                : PendingSubscriptionsScreen(),
          ),
        ],
      ),
    );
  }
}
