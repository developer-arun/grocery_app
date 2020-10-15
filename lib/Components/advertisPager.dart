import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/ListData.dart';

class AdvertisementPager extends StatefulWidget {
  @override
  _AdvertisementPagerState createState() => _AdvertisementPagerState();
}

class _AdvertisementPagerState extends State<AdvertisementPager> {

  //retrieve this list from the server
  List<ListData> promotions=[
    ListData(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    ListData(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
    ListData(url:"https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
        itemBuilder: (context,index) {
          return Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height*0.16,
            width: MediaQuery.of(context).size.width*0.60,
            padding: EdgeInsets.only(left:0,top: 0,),
            child: FlatButton(onPressed: () { print("tap\n"); },
              padding: EdgeInsets.only(left:0,top: 0,),
              splashColor: Colors.transparent,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    child: Image.network('${promotions[index].url}',fit:BoxFit.fill)),
              ),

          );
        });
  }
}


