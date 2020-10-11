import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/Model/contibutors.dart';

import 'package:grocery_app/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  List<Contributors> contri = [
    Contributors(
        name: "Anubhav Rajput",
        nickname: "Anubhav",
        email: "anubhavrajput1804@gmail.com",
        imageurl: "assets/images/anu.jpg"),
    Contributors(
        name: "Harsh Gyanchandani",
        nickname: "Harsh",
        email: "harsh.gyanchandani@gmail.com",
        imageurl: "assets/images/harsh.jpg"),
    Contributors(
        name: "Arun Kumar",
        nickname: "Arun",
        email: "arun12211kumar@gmail.com",
        imageurl: "assets/images/anu.jpg"),
  ];

  void _launchUrl(String emailid) async {
    var url = "mailto:$emailid?subject=Regarding help";
    if (canLaunch(url) != null) {
      await launch(url);
    } else
      throw 'cant launch';
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: kColorPurple,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 120, bottom: 20, left: 30, right: 30),
              width: double.infinity,
              child: Text(
                'Get in touch',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 50),
                      child: Text(
                        'Developed with ❤ by',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage(contri[index].imageurl),
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contri[index].name,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 2,),
                                          Text(
                                            contri[index].email,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.mail,
                                          ),
                                          onPressed: (){
                                            _launchUrl(contri[index].email);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
