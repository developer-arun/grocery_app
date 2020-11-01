import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RatingReviewScreen extends StatefulWidget {
  final String storeId, productId;

  RatingReviewScreen({this.storeId, this.productId});

  @override
  _RatingReviewScreenState createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  //initial rating
  double _rating = 3;
  String _review;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        //basic app bar
        appBar: AppBar(
          backgroundColor: kColorWhite,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kColorPurple,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'SabziWaaley',
            style: TextStyle(
              color: kColorPurple,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                child: Text(
                  "How was the product?",
                  style: TextStyle(
                    fontSize: 25,
                    color: kColorPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                child: Text(
                  "Rate the product!!",
                  style: TextStyle(
                    fontSize: 20,
                    color: kColorPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //implemting rating bar
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                itemSize: 50,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                    default:
                      return Container();
                  }
                },
                onRatingUpdate: (rating) {
                  print(rating);
                  setState(() {
                    // set the value after it is changed
                    _rating = rating;
                  });
                  print(_rating);
                },
              ),

              //showing text according to _rating
              _rating == 1
                  ? Text(
                      "Worse",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  : _rating == 2
                      ? Text(
                          "Poor",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : _rating == 3
                          ? Text(
                              "Average",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : _rating == 4
                              ? Text(
                                  "Good",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.lightGreen,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "Awesome",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),

              //input field for adding review
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[200], spreadRadius: 0.5)
                      ]),
                  //review Container
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Review ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.comment,
                                color: Colors.grey,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200], spreadRadius: 0.5)
                            ]),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: TextFormField(
                          autocorrect: true,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          maxLength: 400,
                          decoration: InputDecoration(
                            hintText: "Describe your experience....",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          obscureText: false,
                          onChanged: (value) {
                            setState(() {
                              _review = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                label: 'Post Review',
                onPressed: () async {
                  print(_review.toString() + _rating.toString());

                  if(_review.isNotEmpty){
                    setState(() {
                      _loading = true;
                    });

                    await _postReview(_rating, _review);

                    setState(() {
                      _loading = false;
                    });
                  }else{
                    AlertBox.showMessageDialog(context, 'Error', 'Please fill up the required field');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //adding data to server
  Future _postReview(double rating, String review) async {
    //can be reused for store review and rating
    Map<String, dynamic> data = {
      "reviewId": UserApi.instance.email + widget.productId,
      "productId": widget.productId,
      "rating": rating,
      "review": review.trim(),
      "userId": UserApi.instance.email
    };
    await FirebaseFirestore.instance
        .collection("Reviews&Ratings")
        .doc(UserApi.instance.email + widget.productId)
        .set(data)
        .then((value) async {
      await AlertBox.showMessageDialog(
          context, 'Success', 'Added review successfully!');
      Navigator.pop(context,'SUCCESS');
    });
  }
}
