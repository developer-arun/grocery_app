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
  bool _loading = true;

  void getStores() async {
    _loading = true;
    stores = await DatabaseServices.getSellerByRating();
    _loading = false;
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
      height: 180,
      child: _loading == false
          ? (stores.length > 0
              ? PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: stores.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return StoreCard(store: stores[index]);
                  },
                )
              : Center(
                  child: Text(
                    'No sellers found in your city',
                    style: TextStyle(
                        color: kColorPurple.withOpacity(0.4), fontSize: 20),
                  ),
                ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
