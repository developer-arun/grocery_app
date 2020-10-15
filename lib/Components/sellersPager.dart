import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/ListData.dart';
import 'package:grocery_app/utilities/constants.dart';

class SellersPager extends StatefulWidget {
  @override
  _SellersPagerState createState() => _SellersPagerState();
}

class _SellersPagerState extends State<SellersPager> {

  List<ListData> promotions = [
    ListData(
        url:
        "https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    ListData(
        url:
        "https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    ListData(
        url:
        "https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index){
          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: kColorWhite,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      promotions[index].url,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(kColorPurple.withOpacity(0.5), BlendMode.srcATop),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kColorPurple.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
