import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/data_display_widget.dart';
import 'package:grocery_app/Components/stock_item_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/store_api.dart';
import 'package:grocery_app/utilities/user_api.dart';

class MyStoreScreen extends StatefulWidget {
  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {

  StoreApi storeApi = StoreApi.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30,top:kToolbarHeight + 50 ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kColorPurple.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StockItemWidget(),
                          StockItemWidget(),
                          StockItemWidget(),
                          StockItemWidget(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Sold Out',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: kColorPurple,
                          ),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kColorPurple.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StockItemWidget(),
                          StockItemWidget(),
                          StockItemWidget(),
                          StockItemWidget(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              //minWidth: double.infinity,
              padding: const EdgeInsets.all(18),
              color: kColorPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              onPressed: () {
                // TODO:CODE
                UserApi userapi=UserApi.instance;
                if(userapi.isSeller)
                  Navigator.pushNamed(context,"/addItem");
                else
                  {
                    AlertBox.showMessageDialog(context,"Error","Please wait until your are a verified seller");
                  }
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


