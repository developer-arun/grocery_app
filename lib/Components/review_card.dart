import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class ReviewCard extends StatefulWidget {
  String user,imageurl,review;
  ReviewCard({this.user,this.imageurl,this.review});
  @override
  _ReviewCardState createState() => _ReviewCardState(user: user,imageurl: imageurl,review: review);
}

class _ReviewCardState extends State<ReviewCard> {
  String user,imageurl,review;
  _ReviewCardState({this.user,this.imageurl,this.review});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: Colors.grey[200],
            blurRadius: 2,spreadRadius: 1,
          )]
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(imageurl),
                  radius: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(user,style: TextStyle(
                    color: kColorPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(review,style: TextStyle(
                  color: kColorPurple,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
