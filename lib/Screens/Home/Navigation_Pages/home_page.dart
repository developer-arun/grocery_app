import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/advertisementPager.dart';
import 'package:grocery_app/Components/categoriesPager.dart';
import 'package:grocery_app/Components/productsPager.dart';
import 'package:grocery_app/Components/sellersPager.dart';
import 'package:grocery_app/Screens/Shopping/all_products_screen.dart';
import 'package:grocery_app/Screens/Shopping/all_sellers_screen.dart';
import 'package:grocery_app/Screens/search_screen.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  final Widget leadingWidget;

  const HomePage({@required this.leadingWidget});
}

class _HomePageState extends State<HomePage> {
  UserApi userApi = UserApi.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        textTheme: TextTheme(
            headline6: TextStyle(
          color: kColorPurple,
        )),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          appTitle,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Text(
                'Hello ${userApi.firstName},',
                style: TextStyle(
                  color: kColorPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Text(
                'Let\'s find some fresh food for you!',
                style: TextStyle(
                  color: kColorPurple.withOpacity(.5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: kColorPurple,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Order something refreshing!!',
                                  style: TextStyle(
                                    color: kColorPurple.withOpacity(0.3),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Top Offers',
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
            AdvertisementPager(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: kColorPurple,
                    ),
                  ),
                ],
              ),
            ),
            CategoriesPager(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: kColorPurple,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductsScreen()));
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
            ProductsPager(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Top Stores',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: kColorPurple,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllSellersScreen()));
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
            SellersPager(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
