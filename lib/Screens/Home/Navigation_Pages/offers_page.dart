import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();

  final Widget leadingWidget;
  const OffersPage({@required this.leadingWidget});
}

class _OffersPageState extends State<OffersPage> {

  DateTime _currentDate=DateTime.now(); //getting current Date
  int date,month,year;
  String timestamp;


  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  bool loading=true; //checking if data has been loaded or not
  int _perpage = 10; //limit of documents reading in one go.
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreOffers = false;
  bool _moreOffersAvailable = true; //boolean variable to check if more products are available
  List<QueryDocumentSnapshot> _Offers = [];
  DocumentSnapshot _lastDocument;
  _getOffers() async {
    Query query = _firebaseFirestore
        .collection("Offers")
        .where("dueDate",isGreaterThanOrEqualTo: timestamp)
    //checking if the offer is valid for this period or not
    //due date and release date format String "ddmmyyyy"
        .where("releaseDate",isLessThanOrEqualTo: timestamp)
        .limit(_perpage);
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await query.get();
    _Offers = querySnapshot.docs;
    _lastDocument = querySnapshot
        .docs[querySnapshot.docs.length - 1]; //finding the last document loaded
    setState(() {
      loading = false;
    });
  }
  //loading more offers if it reached end
  _getMoreOffers() async{
    if (_moreOffersAvailable == false) {
      print("no more offers");
      return;
    }
    if (_gettingMoreOffers == true) {
      return;
    }
    _gettingMoreOffers = true;
    if (_gettingMoreOffers == true) {
      Query query = _firebaseFirestore
          .collection("Offers")
          .startAfter([_lastDocument.id]).limit(_perpage);

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length != 0) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (querySnapshot.docs.length < _perpage) {
        _moreOffersAvailable = false;
      }

      _Offers.addAll(querySnapshot.docs); //adding loaded products to the list

      setState(() {});
      _gettingMoreOffers = false;
    }
  }
  @override
  void initState() {
    date=_currentDate.day;
    month=_currentDate.month;
    year=_currentDate.year;
    timestamp=date.toString()+month.toString()+year.toString();

    _getOffers();
    _scrollController.addListener(() {
      //adding scroll listener to check if more items to be loaded on scrolling
      double _maxscroll = _scrollController.position.maxScrollExtent;
      double _currscroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;

      if (_maxscroll - _currscroll < _delta) {
        _getMoreOffers();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    List<int> gestureAry=List<int>(_Offers.length);
    gestureAry.fillRange(0,_Offers.length,-1);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          'My Offers',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      body: loading?
      Container(
          child: Center(
              child: CircularProgressIndicator()
          )
      )
          :Expanded(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: _Offers.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: GestureDetector(
                onTap: (){
                  if(gestureAry[index]==-1){
                    setState(() {
                      gestureAry[index]=index;
                    });
                  }
                  else{
                    setState(() {
                      gestureAry[index]=-1;
                    });
                  }
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_Offers[index].data()["imageURL"]),
                          fit: BoxFit.cover,
                          colorFilter: gestureAry[index]==-1?null:ColorFilter.mode(
                              kColorPurple.withOpacity(0.3), BlendMode.srcATop),
                        ),
                        borderRadius: gestureAry[index]==-1?BorderRadius.circular(30)
                            :BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                      ),
                    ),
                    gestureAry[index]==-1?Container():
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                      ),
                      child: Column(
                        children: <Widget>[
                          Text("Details",style: TextStyle(color: kColorPurple,fontSize: 15,fontWeight: FontWeight.bold),),
                          SizedBox(height: 4,),
                          Text(_Offers[index].data()["desc"],maxLines: null,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
