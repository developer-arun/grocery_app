import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery;
  FirebaseFirestore _firestoreInstance=FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _SearchResults=[];
  bool _loading =true;  //boolean variable to check if data is currently loading
  int _perpage=10;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController=ScrollController();
  bool _gettingMoreResults=false;
  bool _moreResultsAvail=true;

  _getResults(String searchQuery) async{
    //finding serarchquery in colllection
    Query query= _firestoreInstance
        .collection("SearchQueries")
        .where("caseSearch",isEqualTo: searchQuery)
        .limit(_perpage);
    setState(() {
      _loading=true;
    });
    QuerySnapshot querySnapshot=await query.get();
    _SearchResults=querySnapshot.docs;
    // finding last document loaded
    _lastDocument=querySnapshot.docs[querySnapshot.docs.length-1];
    setState(() {
      _loading=false;
    });
  }
  //getting more results and adding it to list
  _getMoreResults(String search) async{
    if(_gettingMoreResults==false)
    {
      print("Docs are empty now");
      return;
    }
    if(_gettingMoreResults==true){
      Query query =_firestoreInstance
          .collection("SearchQueries")
          .where("name",arrayContains : search)
          .startAfter([_lastDocument.id]).limit(_perpage);
      QuerySnapshot querySnapshot=await query.get();
      if(querySnapshot.docs.length!=0){
        _lastDocument=querySnapshot.docs[querySnapshot.docs.length-1];
      }
      else if(querySnapshot.docs.length<_perpage){
        _moreResultsAvail=false;
      }
      _SearchResults.addAll(querySnapshot.docs);
      setState(() {
        _gettingMoreResults=false;
      });
    }
  }
  //getting data for individual query
  List<QueryDocumentSnapshot> _DATA=[];
  _setDataProducts() async{
    for(int i=0;i<_SearchResults.length;i++)
    {
      DocumentReference Productquery =_firestoreInstance
          .collection("Products")
          .doc("${_SearchResults[i].id}");
      DocumentReference SellerQuery =_firestoreInstance
          .collection("Sellers")
          .doc("${_SearchResults[i].id}");
      DocumentSnapshot productSnapshot=await Productquery.get();
      DocumentSnapshot sellerSnapshot=await SellerQuery.get();
      if(productSnapshot.exists) {
        _DATA.add(productSnapshot);
      }
      if(sellerSnapshot.exists) {
        _DATA.add(sellerSnapshot);
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double _maxscroll = _scrollController.position.maxScrollExtent;
      double _currscroll = _scrollController.position.pixels;
      double _delta = MediaQuery.of(context).size.height * 0.25;
      if(_maxscroll-_currscroll<_delta){
        _getMoreResults(searchQuery);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kColorWhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          "SabziWaaley",
          style: TextStyle(
            fontSize: 24,
            color: kColorPurple,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Form(
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  TextInputWidget(
                    hint: "Order something refreshing!!!",
                    icon: Icons.search,
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        searchQuery=value;
                        searchQuery=searchQuery.toLowerCase();
                      });
                      _getResults(searchQuery);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          _loading==true?
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              :
          Expanded(
            child: Container(
              child: _SearchResults.length==0
                  ?Center(
                child: Text("No data available"),
              )
                  :ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: _SearchResults.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                    //TODO : add card for both product and seller
                    child: Text("${_DATA[index].data()["name"]}"+"\n"+"${_DATA[index].data()["rating"]}"),
                  );
                },
              ),
            ),
          ),
          _gettingMoreResults?
          Center(
            child: Transform.scale(scale: 0.5,
              child: CircularProgressIndicator(),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
