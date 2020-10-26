import 'package:flutter/material.dart';
import 'package:grocery_app/Components/booking_card.dart';
import 'package:grocery_app/Components/menu_item_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/previous_orders_page.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();

  final Widget leadingWidget;

  const OrdersPage({@required this.leadingWidget});
}

class _OrdersPageState extends State<OrdersPage> {
  List<Widget> ordersToDisplay = [];
  bool _loading = false;

  Future getOrders() async {
    ordersToDisplay = [];
    List<Booking> bookings = await DatabaseServices.getBooking();
    for (Booking booking in bookings) {
      Widget widget;
      widget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: BookingCard(
          booking: booking,
          onCancelClick: (){
            setState(() {
              _loading = true;
            });
          },
          onCancelFailed: (error){
            setState(() {
              _loading = false;
            });
            AlertBox.showMessageDialog(context, 'Error', 'Unable to cancel booking\n$error');
          },
          onCancelSuccess: (){
            AlertBox.showMessageDialog(context, 'Success', 'Booking cancelled successfully!');
            ordersToDisplay.remove(widget);
            setState(() {
              _loading = false;
            });
          },
        ),
      );
      ordersToDisplay.add(
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
        child: Scaffold(
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
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: ordersToDisplay.isEmpty ? [
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
                        ]: ordersToDisplay,
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
