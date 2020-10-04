import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/components/data_display_widget.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kColorTransparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            // TODO:CODE
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              // TODO:CODE
            },
          ),
        ],
      ),
      body: Column(
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
                            kColorPurple.withOpacity(.8), BlendMode.srcATop),
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
                        image: AssetImage('assets/images/profile-pic.jpeg'),
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
            'Idhar bio ayegi user ki...',
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
        ],
      ),
    );
  }
}
