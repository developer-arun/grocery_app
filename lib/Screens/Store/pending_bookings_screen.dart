import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/task_status.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PendingBookingsScreen extends StatefulWidget {
  @override
  _PendingBookingsScreenState createState() => _PendingBookingsScreenState();
}

class _PendingBookingsScreenState extends State<PendingBookingsScreen> {

  bool _dataLoaded = false;
  bool _loading = false;
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
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: _dataLoaded
            ? (pendingOrders.length != 0
            ? ListView.builder(
          itemCount: pendingOrders.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          pendingOrders[index].productName,
                          style: TextStyle(
                            color: kColorPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    pendingOrders[index].buyerEmail,
                    style: TextStyle(
                      color: kColorPurple.withOpacity(0.4),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(pendingOrders[index].timestamp)),[d,' ', MM, ', ',yyyy]),
                    style: TextStyle(
                      color: kColorPurple.withOpacity(0.4),
                      fontSize: 14,
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
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });

                            String result = await DatabaseServices
                                .confirmProductBooking(
                                pendingOrders[index].id);
                            if (result ==
                                TaskStatus.SUCCESS.toString()) {
                              pendingOrders.removeAt(index);
                              setState(() {});
                            } else {
                              AlertBox.showMessageDialog(
                                  context,
                                  'Error',
                                  'Unable to confirm booking\n$result');
                            }

                            setState(() {
                              _loading = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButtonWidget(
                          label: 'Delete',
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });

                            String result = await DatabaseServices
                                .declineProductBooking(
                                pendingOrders[index].id);
                            if (result ==
                                TaskStatus.SUCCESS.toString()) {
                              pendingOrders.removeAt(index);
                              setState(() {});
                            } else {
                              AlertBox.showMessageDialog(
                                  context,
                                  'Error',
                                  'Unable to cancel booking\n$result');
                            }

                            setState(() {
                              _loading = false;
                            });
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
