import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/ListData.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProductsPager extends StatefulWidget {
  @override
  _ProductsPagerState createState() => _ProductsPagerState();
}

class _ProductsPagerState extends State<ProductsPager> {

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
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index){
          return Container(
            margin: const EdgeInsets.only(left: 10,right: 5,top: 10,bottom: 10),
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
