import 'package:flutter/material.dart';
import 'package:grocery_app/Components/store_card.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class SellersPager extends StatefulWidget {
  @override
  _SellersPagerState createState() => _SellersPagerState();
}

class _SellersPagerState extends State<SellersPager> {
  List<Store> stores = [];

  void getStores() async {
    stores = await DatabaseServices.getSellerByRating();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getStores();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: stores.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return StoreCard(store: stores[index]);
        },
      ),
    );
  }
}