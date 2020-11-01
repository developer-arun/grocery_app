import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/booking_card.dart';
import 'package:grocery_app/Components/data_display_widget.dart';
import 'package:grocery_app/Components/stock_item_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/store_api.dart';
import 'package:grocery_app/utilities/task_status.dart';
import 'package:grocery_app/utilities/user_api.dart';

import 'current_stock_screen.dart';

class MyStoreScreen extends StatefulWidget {
  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  StoreApi storeApi = StoreApi.instance;

  List<Product> currentStock = [];
  bool displayCurrentStock = false;
  bool displaySoldOut = false;

  List<Widget> soldOutProducts = [];

  Future getCurrentStock() async {
    displayCurrentStock = false;
    currentStock = await DatabaseServices.getCurrentStock();
    displayCurrentStock = true;
    setState(() {});
  }

  Future getSoldOutProducts() async {
    soldOutProducts = [];
    List<Booking> bookings = await DatabaseServices.getRecentlySoldOut();
    for (Booking booking in bookings) {
      soldOutProducts.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kColorWhite,
              boxShadow: [
                BoxShadow(
                  color: kColorPurple.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  booking.productName,
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
                  '${booking.quantity} Kg',
                  style: TextStyle(
                    color: kColorPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs ${booking.price}',
                  style: TextStyle(
                    color: kColorPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  booking.buyerEmail,
                  style: TextStyle(
                    color: kColorPurple,
                  ),
                ),
                Text(
                  '${DateTime.fromMillisecondsSinceEpoch(int.parse(booking.timestamp))}',
                  style: TextStyle(
                    color: kColorPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    displaySoldOut = true;
    setState(() {});
  }

  Future setupStore() async {
    displaySoldOut = false;
    setState(() {});
    await getCurrentStock();
    await getSoldOutProducts();
  }

  @override
  void initState() {
    super.initState();
    setupStore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              child: RefreshIndicator(
            onRefresh: setupStore,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kColorPurple,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: kColorPurple.withOpacity(0.1),
                              blurRadius: 1,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    storeApi.name,
                                    style: TextStyle(
                                      color: kColorWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: kColorWhite,
                                        size: 14,
                                      ),
                                      Text(
                                        storeApi.address,
                                        style: TextStyle(
                                          color: kColorWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            DataDisplayWidget(
                              color: kColorWhite,
                              label: 'Orders',
                              data: storeApi.orders.toString(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              'Current Stock',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: kColorPurple,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CurrentStockScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kColorPurple.withOpacity(.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      displayCurrentStock
                          ? (currentStock.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  height: 200,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: currentStock.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onLongPress: () async {
                                            final value = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'Are you sure you want to remove the product from store?'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text('Yes'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });

                                            if (value) {
                                              String result =
                                                  await DatabaseServices
                                                      .removeProductFromStore(
                                                          currentStock[index]);
                                              if (result ==
                                                  TaskStatus.SUCCESS
                                                      .toString()) {
                                                currentStock.removeAt(index);
                                                setState(() {});
                                              }else{
                                                AlertBox.showMessageDialog(context,'Error', 'Unable to remove product\n$result');
                                              }
                                            }
                                          },
                                          child: StockItemWidget(
                                            product: currentStock[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'Nothing to display',
                                    style: TextStyle(
                                      color: kColorPurple.withOpacity(0.4),
                                    ),
                                  ),
                                ))
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          'Sold Out Today',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: kColorPurple,
                          ),
                        ),
                      ),
                      Expanded(
                        child: displaySoldOut
                            ? (soldOutProducts.isNotEmpty
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: soldOutProducts,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Nothing to display',
                                      style: TextStyle(
                                        color: kColorPurple.withOpacity(0.4),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ))
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              minWidth: double.infinity,
              padding: const EdgeInsets.all(18),
              color: kColorPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/addItem").then((stockUpdated) {
                  if (stockUpdated) {
                    getCurrentStock();
                    getSoldOutProducts();
                  }
                });
              },
              child: Text(
                'Add Item',
                style: TextStyle(
                  color: kColorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
