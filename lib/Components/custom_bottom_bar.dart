import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/clipper/waveclipper.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  Color primary1, primary2;

  CustomBottomBar(this.primary1, this.primary2);

  @override
  _CustomBottomBarState createState() =>
      _CustomBottomBarState(primary1, primary2);
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  Color primary1, primary2;

  _CustomBottomBarState(this.primary1, this.primary2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
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
                          colors: [primary1, primary2])),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print("taped");
                      Navigator.pushNamed(context, '/fruits');
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.remove_circle_outline,
                          size: 30, color: primary2),
                    ),
                  ),
                  Container(),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child:
                          Icon(Icons.shopping_cart, size: 30, color: primary2),
                    ),
                  ),
                  Container(),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.add_circle_outline,
                          size: 30, color: primary2),
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
                    "Remove",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Container(),
                  Text(
                    "Cart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Container(),
                  Text(
                    "Add More",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
