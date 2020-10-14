import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Screens/Store/my_store_screen.dart';
import 'package:grocery_app/Screens/Store/store_details_screen.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  UserApi userApi = UserApi.instance;

  // Display progress indicator until data is loaded
  Widget storePageDisplay = Center(
    child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(kColorPurple),
    ),
  );

  /*
  Function to load details of the seller from database
   */
  Future<void> getSellerDetails() async {
    // ignore: deprecated_member_use
    await Firestore.instance
        .collection('Sellers')
        .doc(userApi.email)
        .get()
        .then((snapshot) {
          // Snapshot loaded
      if(snapshot.exists){
        // Data present - Seller registered
        // TODO: Load data
        storePageDisplay = MyStoreScreen();
        setState(() {});
      }else{
        // Data absent - Seller not registered
        // Replace loading indicator with button
        storePageDisplay = Center(
          child: CustomButtonWidget(
            label: 'Open your store',
            onPressed: (){
              // Open store details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoreDetailsScreen(),
                ),
              ).then((value){
                if(value == 'SUCCESS'){
                  // Display store screen after successfull registration
                  storePageDisplay = MyStoreScreen();
                  setState(() {});
                }
              });
            },
          ),
        );
        setState(() {});
      }
    })
        .catchError((error) {
          // Error in fetching the document
      AlertBox.showMessageDialog(context, 'Error', 'Unable to reach store.\n${error.message}');
    });
  }

  @override
  void initState() {
    super.initState();
    getSellerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: storePageDisplay,
    );
  }
}
