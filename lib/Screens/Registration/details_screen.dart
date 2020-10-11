import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as AUTH;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/Services/location_service.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String address = "";
  TextEditingController addressController = TextEditingController();

  bool _loading = false;

  Position _position;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: kColorWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClippedWidget(
                text: 'Tell us more about you',
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter first name',
                  icon: Icons.person,
                  obscureText: false,
                  onChanged: (value){
                    firstName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter last name',
                  icon: Icons.person,
                  obscureText: false,
                  onChanged: (value){
                    lastName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter phone number',
                  icon: Icons.call,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  onChanged: (value){
                    phoneNumber = '+91' + value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: GestureDetector(
                  child: TextInputWidget(
                    onTap: () async {
                      if(_position == null){
                        setState(() {
                          _loading = true;
                        });
                        _position = await LocationService.getCurrentLocation(context: context);
                        address = await LocationService.getPlace(_position);
                        setState(() {
                          addressController.text = address;
                          _loading = false;
                        });
                      }
                    },
                    controller: addressController,
                    hint: 'Enter address',
                    icon: Icons.location_on,
                    obscureText: false,
                    onChanged: (value){
                      address = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: CustomButtonWidget(
                  label: 'Continue',
                  onPressed: () async {

                    // TODO:VERIFY PHONE NUMBER
                    if(firstName.isNotEmpty && lastName.isNotEmpty && phoneNumber.isNotEmpty && _position != null){
                      setState(() {
                        _loading = true;
                      });
                      User user =  User(
                        email: AUTH.FirebaseAuth.instance.currentUser.email,
                        fistName: firstName,
                        lastName: lastName,
                        address: address,
                        longitude: _position.longitude,
                        latitude: _position.latitude,
                        phoneNumber: phoneNumber,
                        isSeller: false,
                        orders: 0,
                      );
                      await updateUserDetails(
                          user: user,
                          context: context,
                      );
                    }else{
                      AlertBox.showMessageDialog(context, 'Error', 'Please fill up all the fields!');
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateUserDetails({User user, BuildContext context}) async {

    Map<String,dynamic> data = {
      'email': user.email,
      'firstName' : user.fistName,
      'lastName' :user.lastName,
      'address' : user.address,
      'latitude' : user.latitude,
      'longitude' : user.longitude,
      'phoneNumber' : user.phoneNumber,
      'orders' : user.orders,
      'isSeller' : user.isSeller,
    };

    FirebaseFirestore
        .instance
        .collection("Users")
        .doc(user.email)
        .set(data).then((value) async {
      await AlertBox.showMessageDialog(context, 'Success', 'User details stored successfully!');
      setState(() {
        _loading = false;
      });
      Navigator.pushReplacementNamed(context, '/home');
    }).catchError((error){
      AlertBox.showMessageDialog(context, 'Error', 'An error occurred in saving user data\n${error.message}');
    });

  }
}



