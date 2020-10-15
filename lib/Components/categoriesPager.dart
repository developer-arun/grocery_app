import 'package:flutter/material.dart';
import 'package:grocery_app/Components/ListData.dart';
import 'package:grocery_app/utilities/constants.dart';

class CategoriesPager extends StatefulWidget {
  @override
  _CategoriesPagerState createState() => _CategoriesPagerState();
}

class _CategoriesPagerState extends State<CategoriesPager> {

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
      height: 200,
      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index){
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
          );
        },
      ),
    );
  }
}
