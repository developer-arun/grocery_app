import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class StoreNotificationsScreen extends StatefulWidget {
  @override
  _StoreNotificationsScreenState createState() =>
      _StoreNotificationsScreenState();
}

class _StoreNotificationsScreenState extends State<StoreNotificationsScreen> {
  bool _dataLoaded = false;
  List<Booking> pendingOrders = [];

  Future getPendingBookings() async {
    List<Booking> bookings = await DatabaseServices.getPendingBooking();
    _dataLoaded = true;
    pendingOrders = bookings;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPendingBookings();
  }

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: _dataLoaded
            ? (pendingOrders.length != 0
                ? ListView.builder(
                    itemCount: pendingOrders.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding:  const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: kColorPurple.withOpacity(0.1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              pendingOrders[index].productName,
                              style: TextStyle(
                                color: kColorPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${pendingOrders[index].quantity} Kg',
                              style: TextStyle(
                                color: kColorPurple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              pendingOrders[index].buyerEmail,
                              style: TextStyle(
                                color: kColorPurple,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CustomButtonWidget(
                                    label: 'Confirm',
                                    onPressed: (){
                                      // TODO: CODE
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CustomButtonWidget(
                                    label: 'Delete',
                                    onPressed: (){
                                      // TODO: CODE
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Nothing to display',
                    ),
                  ))
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
