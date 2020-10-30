import 'package:flutter/material.dart';
import 'package:grocery_app/Components/booking_card.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MySubscriptionsPage extends StatefulWidget {
  @override
  _MySubscriptionsPageState createState() => _MySubscriptionsPageState();
}

class _MySubscriptionsPageState extends State<MySubscriptionsPage> {

  List<Widget> subscriptionsToDisplay = [];
  bool _loading = false;

  Future getOrders() async {
    subscriptionsToDisplay = [];
    List<Booking> subscriptions = await DatabaseServices.getSubscriptions();
    for (Booking booking in subscriptions) {
      Widget widget;
      widget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: BookingCard(
          booking: booking,
          isSubscription: true,
          onCancelClick: (){
            setState(() {
              _loading = true;
            });
          },
          onCancelFailed: (error){
            setState(() {
              _loading = false;
            });
            AlertBox.showMessageDialog(context, 'Error', 'Unable to cancel subscription\n$error');
          },
          onCancelSuccess: (){
            AlertBox.showMessageDialog(context, 'Success', 'Subscription cancelled successfully!');
            subscriptionsToDisplay.remove(widget);
            setState(() {
              _loading = false;
            });
          },
        ),
      );
      subscriptionsToDisplay.add(
        widget,
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
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: RefreshIndicator(
        onRefresh: getOrders,
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: subscriptionsToDisplay.isEmpty ? [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Nothing to display',
                        style: TextStyle(
                          fontSize: 20,
                          color: kColorPurple.withOpacity(0.4),
                        ),
                      ),
                    ),
                  )
                ]: subscriptionsToDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
