import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/advertisPager.dart';
import 'package:grocery_app/Components/custom_bottomNavBar.dart';

class FruitsMain extends StatefulWidget {
  Color primary1,primary2;
  String title;
  FruitsMain(this.primary1,this.primary2,this.title);

  @override
  _FruitsMainState createState() => _FruitsMainState(primary1,primary2,title);
}

class _FruitsMainState extends State<FruitsMain> {
  Color primary1,primary2;
  String Pagetitle;
  _FruitsMainState(this.primary1,this.primary2, this.Pagetitle);

  bool menuiscolapsed=true;
  static const Duration duration =const Duration(milliseconds: 200);
  double scwidth,scheight;


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    scheight=size.height;
    scwidth=size.width;
    return AnimatedPositioned(
      duration: duration,
      top: menuiscolapsed ? 0 : scheight *0.15,
      left: menuiscolapsed ? 0 : scwidth *0.65,
      bottom: menuiscolapsed ? 0 : scheight *0.15,
      right: menuiscolapsed ? 0 : -scwidth *0.45,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: primary2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                          color: primary2,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.menu, color: primary1,
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
                          color: primary2,
                          shadowColor: primary2,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right:40),
                                child: Text(Pagetitle,
                                    style: TextStyle(fontSize: 24,
                                        color: primary1,
                                        fontFamily: "Pacifico"),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_cart, color: primary1,
                                  size: 30,),
                                onPressed: () {

                                },
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
              Text("ORDER FRUITS",
                style: TextStyle(
                  fontFamily: "Pacifico",
                  color: primary1,
                  fontSize: 25,
                ),textAlign: TextAlign.center,
              )
            ],
          ),
          bottomNavigationBar: CustomBtmNavBAR(Colors.orangeAccent[700],primary1),
        ),

      ),
    );
  }
}
