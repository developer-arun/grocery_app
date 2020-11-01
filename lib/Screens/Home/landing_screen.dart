import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/menu_item_widget.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/home_page.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

import 'Navigation_Pages/contact_us_page.dart';
import 'Navigation_Pages/orders_page.dart';
import 'Navigation_Pages/diet_screen.dart';
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
          WillPopScope(
            onWillPop: () async {
              final value = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sure you want to exit?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        FlatButton(
                          child: Text('Yes, exit'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  }
              );

              return value == true;
            },
            child: dashboard(context),
          ),
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
                  Text(
                    '${userApi.firstName} ${userApi.lastName}',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userApi.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: kColorPurple.withOpacity(0.5),
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
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Diet',
                                icon: Icons.pie_chart,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 1;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Orders',
                                icon: Icons.shop,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 2;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'My Store',
                                icon: Icons.store_mall_directory,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 3;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Settings',
                                icon: Icons.settings,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 4;
                                  });
                                },
                              ),
                              MenuItemWidget(
                                label: 'Contact Us',
                                icon: Icons.info_outline,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 5;
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
    Widget leadingWidget = IconButton(
      icon: Icon(
        isCollapsed ? Icons.menu : Icons.arrow_back_ios,
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
    );

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
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
          child: ClipRRect(
            borderRadius: !isCollapsed ? BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0)) : BorderRadius.zero,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: kColorWhite,
              body: IndexedStack(
                index: currentIndex,
                children: <Widget>[
                  HomePage(
                    leadingWidget: leadingWidget,
                  ), //0
                  DietScreen(
                    leadingWidget: leadingWidget,
                  ), //1
                  OrdersPage(
                    leadingWidget: leadingWidget,
                  ), //2
                  StorePage(
                    leadingWidget: leadingWidget,
                  ), //3//4
                  SettingsPage(
                    leadingWidget: leadingWidget,
                  ), //4
                  ContactUsPage(
                    leadingWidget: leadingWidget,
                  ), //5
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
