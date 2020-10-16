import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/clipper/waveclipper.dart';

class CustomBtmNavBAR extends StatefulWidget {
  Color primary1,primary2;
  CustomBtmNavBAR(this.primary1,this.primary2);
  @override
  _CustomBtmNavBARState createState() => _CustomBtmNavBARState(primary1,primary2);
}

class _CustomBtmNavBARState extends State<CustomBtmNavBAR> {
  Color primary1,primary2;
  int count=0;
  _CustomBtmNavBARState(this.primary1,this.primary2);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.09,
      child: Material(
      color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
            bottom: 0,
              child: ClipPath(
              clipper: WaveClipper(),
                child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primary1,primary2
                    ]
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 27,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    if(count<=0)
                      {
                        setState(() {
                          count=0;
                        });
                      }
                    else
                      setState(() {
                      --count;
                    });
                  },
                  child: CircleAvatar(
                    radius: 30,
                   backgroundColor: Colors.transparent,
                   child: Icon(
                     Icons.remove_circle_outline,
                     size: 30,
                     color: primary2),
                  ),
                ),
                Container(),
                GestureDetector(
                  onTap: (){
                        //todo add the data to cart
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: primary2),

                  ),
                ),
                Container(),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      ++count;
                    });
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: primary2),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "-1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Container(),
                Text(
                  "$count",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Container(),
                Text(
                  "+1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    ),);
  }

}
