import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/User.dart';
import 'package:grocery_app/Services/location_service.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart' as AUTH;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  final Widget leadingWidget;

  const SettingsPage({@required this.leadingWidget});
}

class _SettingsPageState extends State<SettingsPage> {
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String address = "";
  TextEditingController addressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool _loading = false;

  Position _position;

  @override
  void initState() {
    super.initState();
    UserApi userApi = UserApi.instance;
    firstNameController.text = userApi.firstName;
    lastNameController.text = userApi.lastName;
    phoneNumberController.text = userApi.phoneNo;
    addressController.text = userApi.address;
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kColorPurple,
          ),
          backgroundColor: kColorWhite,
          elevation: 0,
          leading: widget.leadingWidget,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(
              color: kColorPurple,
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Text(
                  'Update Details',
                  style: TextStyle(
                    color: kColorPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextInputWidget(
                  controller: firstNameController,
                  hint: 'Enter first name',
                  icon: Icons.person,
                  obscureText: false,
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextInputWidget(
                  controller: lastNameController,
                  hint: 'Enter last name',
                  icon: Icons.person,
                  obscureText: false,
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextInputWidget(
                  controller: phoneNumberController,
                  hint: 'Enter phone number',
                  icon: Icons.call,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = '+91' + value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: GestureDetector(
                  child: TextInputWidget(
                    onTap: () async {
                      if (_position == null) {
                        setState(() {
                          _loading = true;
                        });
                        _position = await LocationService.getCurrentLocation(
                            context: context);
                        if (_position != null) {
                          address = await LocationService.getPlace(_position);
                          setState(() {
                            addressController.text = address;
                            _loading = false;
                          });
                        }
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
                    controller: addressController,
                    hint: 'Enter address',
                    icon: Icons.location_on,
                    obscureText: false,
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: CustomButtonWidget(
                    label: 'Save Changes',
                    onPressed: () async {
                      // TODO:VERIFY PHONE NUMBER
                      if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          _position != null) {
                        setState(() {
                          _loading = true;
                        });
                        // Saving user details in the database
                        User user = User(
                          email: AUTH.FirebaseAuth.instance.currentUser.email,
                          fistName: firstNameController.text,
                          lastName: lastNameController.text,
                          address: address,
                          longitude: _position.longitude,
                          latitude: _position.latitude,
                          phoneNumber: phoneNumberController.text,
                          isSeller: false,
                          orders: 0,
                        );
                        await updateUserDetails(
                          user: user,
                          context: context,
                        );
                      } else {
                        if(_position == null){
                          AlertBox.showMessageDialog(context, 'Error', 'Please select address again.');
                        }else
                        AlertBox.showMessageDialog(
                            context, 'Error', 'Please fill up all the fields!');
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  /*
  Function to save the user's details in firestore database
   */
  Future updateUserDetails({User user, BuildContext context}) async {
    Map<String, dynamic> data = {
      'email': user.email,
      'firstName': user.fistName,
      'lastName': user.lastName,
      'address': user.address,
      'latitude': user.latitude,
      'longitude': user.longitude,
      'phoneNumber': user.phoneNumber,
      'orders': user.orders,
      'isSeller': user.isSeller,
    };

    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email)
        .set(data)
        .then((value) async {
      // After successfully saving the details, sowing a success dialog and moving to home screen
      UserApi userApi = UserApi.instance;
      userApi.email = user.email;
      userApi.firstName = user.fistName;
      userApi.lastName = user.lastName;
      userApi.address = user.address;
      userApi.phoneNo = user.phoneNumber;
      userApi.latitude = user.latitude;
      userApi.longitude = user.longitude;
      userApi.isSeller = false;
      userApi.orders = 0;
      AlertBox.showMessageDialog(context, 'Success', 'User details updated successfully! Restart the app for viewing complete changes!');
      setState(() {
        _loading = false;
      });

    }).catchError((error) {
      // Displaying error in case of any failure
      AlertBox.showMessageDialog(context, 'Error',
          'An error occurred in saving user data\n${error.message}');
    });
  }
}
