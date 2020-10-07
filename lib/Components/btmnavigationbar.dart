import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/clipper/waveclipper.dart';

class CustomBtmNavBAR extends StatefulWidget {
  @override
  _CustomBtmNavBARState createState() => _CustomBtmNavBARState();
}

class _CustomBtmNavBARState extends State<CustomBtmNavBAR> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 110,
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
                      Colors.purpleAccent[700],
                      Colors.deepPurpleAccent[700],
                    ]
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){ },
                  child: CircleAvatar(
                    radius: 30,
                   backgroundColor: Colors.white.withOpacity(0.9),
                   child: Icon(
                     Icons.arrow_back_ios,
                     color: Colors.purpleAccent[700],),
                  ),
                ),
                Container(),
                GestureDetector(
                  onTap: (){ },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: Icon(
                      Icons.search,
                      color: Colors.purpleAccent[700],),

                  ),
                ),
                Container(),
                GestureDetector(
                  onTap: (){

                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purpleAccent[700],),
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
                  "Fruits",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Container(),
                Text(
                  "Search",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Container(),
                Text(
                  "Vegies",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    ),);
  }

}
