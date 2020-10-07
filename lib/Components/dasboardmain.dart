import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/addvertisPager.dart';
import 'package:grocery_app/Components/btmnavigationbar.dart';

class Dasboardmain extends StatefulWidget {
  @override
  _DasboardmainState createState() => _DasboardmainState();
}

class _DasboardmainState extends State<Dasboardmain> {
  bool menuiscolapsed=true;
  Color dashbordTextIconclr,dashbordbackgrdclr,dashbordIconbackgrdclr;
  static const Duration duration =const Duration(milliseconds: 200);
  double scwidth,scheight;
  String Pagetitle="DASHBARD";
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    scheight=size.height;
    scwidth=size.width;
    dashbordbackgrdclr=Colors.white;
    dashbordIconbackgrdclr=Colors.deepPurple[700];
    dashbordTextIconclr=Colors.white;
    return AnimatedPositioned(
      duration: duration,
      top: menuiscolapsed ? 0 : scheight *0.15,
      left: menuiscolapsed ? 0 : scwidth *0.65,
      bottom: menuiscolapsed ? 0 : scheight *0.15,
      right: menuiscolapsed ? 0 : -scwidth *0.45,
      child: Material(
        child: Scaffold(
          backgroundColor: dashbordbackgrdclr,
          body: Column(
            children: <Widget>[
              //app bar
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: dashbordIconbackgrdclr,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                             ),
                          child: IconButton(
                            icon: Icon(Icons.menu, color: dashbordTextIconclr,
                              size: 30,),
                            onPressed: () {
                              setState(() {
                                menuiscolapsed = !menuiscolapsed;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right:40),
                                child: Text(Pagetitle,
                                    style: TextStyle(fontSize: 24,
                                        color: Colors.deepPurple,
                                        fontFamily: "Pacifico")
                                ),
                              ),
                              Material(
                                color: dashbordIconbackgrdclr,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart, color: dashbordTextIconclr,
                                    size: 30,),
                                  onPressed: () {

                                  },
                                ),
                              ),
                            ],
                          ),
                          elevation: 7,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0)),
                        ),
                      ),
                    ]),
              ),
              Container(
                height: 200,
                child: AdvertisementPager(),
              ),
            ],
          ),
          bottomNavigationBar: CustomBtmNavBAR(),
        ),

      ),
    );
  }
}
