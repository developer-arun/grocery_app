import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primaryColor: Colors.deepPurple,
//        accentColor: Color(0xFFFEF9EB),
//      ),
//      home:
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Contact Us',
          style:TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          )),
        ),
        body:Column(
          children:[
            Container(
              height:90.0,
              color:Theme.of(context).primaryColor,
            ),
            Container(
              height:500.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text('Contributors',
                    style:TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,

                    ),
                    ),

                  ],
                ),
              ),

            )

          ],
        ),
      );

