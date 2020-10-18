import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/ListData.dart';
import 'package:grocery_app/utilities/constants.dart';

class AdvertisementPager extends StatefulWidget {
  @override
  _AdvertisementPagerState createState() => _AdvertisementPagerState();
}

class _AdvertisementPagerState extends State<AdvertisementPager> {
  //retrieve this list from the server
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
      child: PageView.builder(
        itemCount: 3,
        physics: BouncingScrollPhysics(),
        // TODO: ENABLE AUTO SCROLL
        scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context,int index){
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
