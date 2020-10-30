import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/task_status.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PendingSubscriptionsScreen extends StatefulWidget {
  @override
  _PendingSubscriptionsScreenState createState() => _PendingSubscriptionsScreenState();
}

class _PendingSubscriptionsScreenState extends State<PendingSubscriptionsScreen> {

  bool _dataLoaded = false;
  bool _loading = false;
  List<Booking> pendingSubscriptions = [];

  Future getPendingSubscriptions() async {
    List<Booking> bookings = await DatabaseServices.getPendingSubscription();
    _dataLoaded = true;
    pendingSubscriptions = bookings;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPendingSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: _dataLoaded
            ? (pendingSubscriptions.length != 0
            ? ListView.builder(
          itemCount: pendingSubscriptions.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
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
                    pendingSubscriptions[index].productName,
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
                    '${pendingSubscriptions[index].quantity} Kg',
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
                    pendingSubscriptions[index].buyerEmail,
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
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });

                            String result = await DatabaseServices
                                .confirmSubscriptionBooking(
                                pendingSubscriptions[index].id);
                            if (result ==
                                TaskStatus.SUCCESS.toString()) {
                              pendingSubscriptions.removeAt(index);
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
                                .declineSubscriptionBooking(
                                pendingSubscriptions[index].id);
                            if (result ==
                                TaskStatus.SUCCESS.toString()) {
                              pendingSubscriptions.removeAt(index);
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
