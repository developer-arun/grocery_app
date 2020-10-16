import 'package:flutter/material.dart';
import 'package:grocery_app/Components/stock_item_widget.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StockItemWidget(),
                SizedBox(height: 5,),
                StockItemWidget(),SizedBox(height: 5,),
                StockItemWidget(),SizedBox(height: 5,),
                StockItemWidget(),SizedBox(height: 5,),
                StockItemWidget(),SizedBox(height: 5,),
                StockItemWidget(),SizedBox(height: 5,),
                StockItemWidget(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
