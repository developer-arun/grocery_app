import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class ViewReviewsScreen extends StatefulWidget {
  String productID;
  ViewReviewsScreen({this.productID});
  @override
  _ViewReviewsScreenState createState() => _ViewReviewsScreenState();
}
class _ViewReviewsScreenState extends State<ViewReviewsScreen> {
  FirebaseFirestore firestoreInstance=FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _Reviews=[];
  List<QueryDocumentSnapshot> _User=[];
  //getting reviews from firestore
  _getReviews() async{
    Query query=firestoreInstance
        .collection("Reviews&Ratings")
        .where("productId",isEqualTo: widget.productID);
    QuerySnapshot snapshot=await query.get();
    _Reviews=snapshot.docs;
  }
  _getUser() async{
    for(int i=0;i<_Reviews.length;i++){
      DocumentSnapshot snapshot=(await firestoreInstance
          .collection("Users")
          .where("email",isEqualTo: _Reviews[i].data()['userId'])
          .get()) as DocumentSnapshot;
      _User.add(snapshot);
    }
  }

  @override
  void initState() {
    _getReviews();
    _getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
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
              appTitle,
              style: TextStyle(
                color: kColorPurple,
                fontSize: 24,
              ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: _Reviews.length,
          itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.pinkAccent[100],spreadRadius: 1),],
                color: Colors.transparent
              ),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                            color: Colors.deepPurple[300]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("${_User[index].data()['name']}",
                              style: TextStyle(
                                color: kColorPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text("${_Reviews[index].data()['rating']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                                SizedBox(width: 4,),
                                Icon(Icons.star_half,color: Colors.yellow,)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                            color: Colors.purple[100]
                        ),
                          child: Text("${_Reviews[index].data()['review']}",
                              maxLines: null,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              )
                          ),
                        ),
                    ]
                  )
            );
          }),
      );
  }
}
