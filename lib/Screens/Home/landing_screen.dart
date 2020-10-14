import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/menu_item_widget.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/home_page.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

import 'Navigation_Pages/cart_page.dart';
import 'Navigation_Pages/contact_us_page.dart';
import 'Navigation_Pages/offers_page.dart';
import 'Navigation_Pages/orders_page.dart';
import 'Navigation_Pages/profile_page.dart';
import 'Navigation_Pages/settings_page.dart';
import 'Navigation_Pages/store_page.dart';


class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 250);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  UserApi userApi = UserApi.instance;
  int currentIndex = 0;
  Color appBarColors = kColorPurple;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: kColorWhite,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile-pic.jpeg'),
                    radius: 50,
                  ),
                  Text(
                    '${userApi.firstName} ${userApi.lastName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userApi.email,
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    width: 200,
                    height: 16,
                    child: Text(
                      userApi.address,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MenuItemWidget(
                                label: 'Home',
                                icon: Icons.home,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 0;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Profile',
                                icon: Icons.person,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 1;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Cart',
                                icon: Icons.shopping_cart,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 2;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Orders',
                                icon: Icons.shop,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 3;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Store',
                                icon: Icons.store_mall_directory,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 4;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Offers',
                                icon: Icons.local_offer,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 5;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Settings',
                                icon: Icons.settings,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 6;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Contact Us',
                                icon: Icons.info_outline,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 7;
                                    appBarColors = kColorWhite;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  MenuItemWidget(
                    label: 'Logout',
                    icon: Icons.exit_to_app,
                    onPressed: () {
                      // TODO:SHOW CONFIRMATION DIALOG
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacementNamed(context, '/login');
                      }).catchError((error) {
                        AlertBox.showMessageDialog(context, 'Error',
                            'Unable to log out.\n${error.message}');
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      height: screenHeight,
      top: isCollapsed ? 0 : 0.15 * screenHeight,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 10,
          color: kColorTransparent,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: kColorWhite,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(45) ,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    IconButton(
                        icon: Icon(
                          isCollapsed ? Icons.menu : Icons.arrow_back_ios,
                          color: appBarColors,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                    Text(
                        "          SabziWaaley",
                        style: TextStyle(
                          fontSize: 24,
                          color: appBarColors,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              currentIndex==0?Icons.add_shopping_cart:null),
                          color: kColorPurple,
                          onPressed: currentIndex==0?(){
                            // TODO transfer to cart screen
                            setState(() {
                              currentIndex=2;
                            });
                          }:null,
                        ),
                        IconButton(
                          icon: Icon(
                              (currentIndex==0||currentIndex==2)?Icons.edit_location:null),
                          color: kColorPurple,
                          onPressed:  (currentIndex==0||currentIndex==2)?()
                          {
                            // TODO change address functionality
                          }:null,
                        ),
                      ],
                    )
                    ],
                  ),
                ),
              ),
              // appBar: AppBar(
              //   backgroundColor: kColorTransparent,
              //   elevation: 0,
              //   centerTitle: true,
              //   title: Text(
              //     "SabziWaaley",
              //     style: TextStyle(
              //       fontSize: 24,
              //       color: appBarColors,
              //     ),
              //   ),
              //   leading: IconButton(
              //     icon: Icon(
              //       isCollapsed ? Icons.menu : Icons.arrow_back_ios,
              //       color: appBarColors,
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         if (isCollapsed)
              //           _controller.forward();
              //         else
              //           _controller.reverse();
              //         isCollapsed = !isCollapsed;
              //       });
              //     },
              //   ),
              //
              // ),
              body: IndexedStack(
                index: currentIndex,
                children: <Widget>[
                  HomePage(),
                  ProfilePage(),
                  CartPage(),
                  OrdersPage(),
                  StorePage(),
                  OffersPage(),
                  SettingsPage(),
                  ContactUsPage(),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
