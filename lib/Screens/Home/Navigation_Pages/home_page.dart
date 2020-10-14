import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/Components/advertisPager.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:68),
      child: Scaffold(
        backgroundColor: kColorWhite,
        body: Column(
          children: <Widget>[
            //search bar
            Form(
              child: Padding(
                padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                child: Column(
                  children: [
                    TextInputWidget(
                      hint:  "Order something refreshing!!!",
                      icon: Icons.search,
                      obscureText: false,
                      onChanged: (value) {
                      },
                      onTap: (){
                        Navigator.pushNamed(context,"/search");
                      },
                    ),
                  ],
                ),
              ),
            ),
            //offers
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 12,left: 10,right: 0),
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Top Offers"
                            ,style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),),
                          FlatButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("see more",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black38
                              ),
                            ),
                            color: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                      height: MediaQuery.of(context).size.height*0.18,
                      color: Colors.transparent,
                      child: AdvertisementPager()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12,left: 10,right: 0),
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Categories"
                            ,style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),),
                          FlatButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                              child: Text("see more",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black38
                                ),
                              ),
                            color: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),

                    Container(
                        height: MediaQuery.of(context).size.height*0.18,
                        color: Colors.transparent,
                        child: AdvertisementPager()
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12,left: 10,right: 0),
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Top Sellers"
                              ,style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {

                                });
                              },
                              child: Text("see more",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black38
                                ),
                              ),
                              color: Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height:  MediaQuery.of(context).size.height*0.18,
                      child: AdvertisementPager(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12,left: 10,right: 0),
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Items of the day"
                              ,style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {

                                });
                              },
                              child: Text("see more",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black38
                                ),
                              ),
                              color: Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height:  MediaQuery.of(context).size.height*0.18,
                      child: AdvertisementPager(),
                    ),
                ],
              ),
            ),
          ],
        ),

      )
    );
  }
}
