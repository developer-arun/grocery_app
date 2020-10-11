import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/menu_item_widget.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/cart_page.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/offers_page.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/orders_page.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/profile_page.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/settings_page.dart';
import 'package:grocery_app/screens/Home/Navigation%20Pages/store_page.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

import 'Navigation Pages/contact_us_page.dart';
import 'Navigation Pages/home_page.dart';

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
                    height: 30,
                  ),
                  Text(
                    '${userApi.firstName} ${userApi.lastName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userApi.email,
                    style: TextStyle(fontSize: 14),
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
                                icon: Icons.home_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 0;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Profile',
                                icon: Icons.person_outline,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 1;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Cart',
                                icon: Icons.shopping_cart_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 2;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Orders',
                                icon: Icons.shopping_bag_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 3;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Store',
                                icon: Icons.store_mall_directory_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 4;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Offers',
                                icon: Icons.local_offer_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 5;
                                    appBarColors = kColorPurple;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Settings',
                                icon: Icons.settings_outlined,
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
                    icon: Icons.logout,
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
          borderRadius: BorderRadius.circular(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: kColorWhite,
              appBar: AppBar(
                backgroundColor: kColorTransparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "SabziWaaley",
                  style: TextStyle(
                    fontSize: 24,
                    color: appBarColors,
                  ),
                ),
                leading: IconButton(
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
              ),
              body: IndexedStack(
                index: currentIndex,
                children: [
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
