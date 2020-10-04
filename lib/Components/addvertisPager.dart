import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/Advertisement.dart';

class AdvertisementPager extends StatefulWidget {
  @override
  _AdvertisementPagerState createState() => _AdvertisementPagerState();
}

class _AdvertisementPagerState extends State<AdvertisementPager> {

  //retrieve this list from the server
  List<Advertisement> promotions=[
    Advertisement(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    Advertisement(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    Advertisement(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
        itemBuilder: (context,index) {
          return Container(
            height: MediaQuery.of(context).size.height*0.16,
             width: MediaQuery.of(context).size.width*0.65,
            child: FlatButton(onPressed: () { print("tap\n"); },
              splashColor: Colors.transparent,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    child: Image.network('${promotions[index].url}',fit: BoxFit.fitWidth,)),
              ),

          );
        });
  }
}


