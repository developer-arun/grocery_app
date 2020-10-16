import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/Components/custom_toggle_bar.dart';
import 'package:grocery_app/Components/data_display_widget.dart';
import 'package:grocery_app/Components/order_card.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {

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
          color: Colors.transparent,
          child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: kColorWhite,
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: ClipPath(
                              clipper: OvalBottomBorderClipper(),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                decoration: BoxDecoration(
                                  color: kColorPurple,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/cover.jpg'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        kColorPurple.withOpacity(.8),
                                        BlendMode.srcATop),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: kColorWhite,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kColorPurple.withOpacity(.4),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/profile-pic.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: kColorWhite, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Harsh Gyanchandani',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kColorPurple,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Bhopal, India',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kColorPurple,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          DataDisplayWidget(
                            label: 'Rating',
                            data: '4.5',
                          ),
                          DataDisplayWidget(
                            label: 'Reviews',
                            data: '17',
                          ),
                          DataDisplayWidget(
                            label: 'Orders',
                            data: '24',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kColorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: kColorPurple.withOpacity(.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                                  child: CustomToggleBar(
                                    selectedTab: 0,
                                    onTabChanged: (value){
                                      //TODO:CODE
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
//              child: Wrap(
//                alignment: WrapAlignment.spaceBetween,
//                crossAxisAlignment: WrapCrossAlignment.end,
//                children: [
//                  Text(
//                    'Past Orders',
//                    style: TextStyle(
//                      fontSize: 30,
//                      color: kColorPurple,
//                    ),
//                  ),
//                  Text(
//                    'View All',
//                    style: TextStyle(
//                      fontSize: 20,
//                      color: kColorPurple.withOpacity(.5),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            SingleChildScrollView(
//              scrollDirection: Axis.horizontal,
//              child: Row(
//                children: [
//                  OrderCard(),
//                  OrderCard(),
//                  OrderCard(),
//                ],
//              ),
//            )
                    ],
                  ),
              ),
            ],
          ),
      ),
        )
    );

  }
}


