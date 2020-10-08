import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/Screens/ContactUs/contibutors.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  List<Contributors> contri=[
    Contributors(name:"Anubhav Rajput",nickname:"Anubhav",email:"anubhavrajput1804@gmail.com",imageurl:"assets/images/anu.jpg"),
    Contributors(name:"Harsh Gyanchandani",nickname:"Harsh",email:"harsh.gyanchandani@gmail.com",imageurl:"assets/images/harsh.jpg"),
    Contributors(name:"Arun Kumar",nickname:"Arun",email:"arun12211kumar@gmail.com",imageurl:"assets/images/anu.jpg"),

  ];

  void _launchUrl(String emailid)async{
    var url="mailto:$emailid?subject=Regarding help";
    if(canLaunch(url) != null) {
      await launch(url);
    }
    else
      throw 'cant launch';
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Color(0xFFFEF9EB),
      ),
      home:Scaffold(
      backgroundColor: Colors.indigoAccent,
//      appBar: AppBar(
//        title:Text('Support'),
//        centerTitle: true,
//
//      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            width: 1000.0,
            color: Colors.indigoAccent,
            child:Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child:
                  Text(
                    'Contact us',
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    ),
                  ),
              ),
        alignment: Alignment(0.0,0.6),
            ),
          Expanded(
            child: Container(
//              constraints: BoxConstraints.expand(height:500.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 224, 3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                  )
              ),
//              child: Padding(
//                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Contributors',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    Container(
                      height:120,
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal:45.0),
                        child: ListView.builder(
                          padding: EdgeInsets.only(left:20.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                            itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  CircleAvatar(radius:35.0,
                                    backgroundImage: AssetImage(contri[index].imageurl),
                                  ),

                                  Text(contri[index].nickname,
                                  style:TextStyle(

                                  )),
                                ],
                              ),
                            );

                             }
                    ),
                      )
                    ),
                    Expanded(
                      child: Container(
                        height: 600.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              boxShadow:[ BoxShadow(
                                color:Color.fromRGBO(143, 148, 251, 3),
                                blurRadius: 8.0,
                                offset: Offset(0,8),
                              )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:0.0),
                            child: ListView.builder(
                              itemCount: 3,
                                itemBuilder:(BuildContext context,int index){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0) ,
                                       decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow:[ BoxShadow(
                                        color:Color.fromRGBO(143, 148, 251, 3),
                                        blurRadius: 8.0,
                                        offset: Offset(3,5),
                                      )]
                                  ),
                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35.0,
                                            backgroundImage: AssetImage(contri[index].imageurl),
                                          ),
                                          SizedBox(width: 20.0),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(contri[index].name,
                                              style: TextStyle(
                                                color:Colors.blueGrey,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              SizedBox(height: 8.0),

                                              GestureDetector(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(contri[index].email,
                                                      style: TextStyle(
                                                        color:Colors.blueGrey,
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
//                                                    Icon(Icons.email),
                                                  ],
                                                ),
                                                onTap:() {_launchUrl("anubhavrajput1804@gmail.com");}
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                );
                                },
                    ),
                          ),
                        )
                    )

                  ],
                ),
              ),

            ),


        ],
      ),
    )
    );
  }
}

