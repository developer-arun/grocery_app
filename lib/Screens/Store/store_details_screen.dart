import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/Services/location_service.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/store_api.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StoreDetailsScreen extends StatefulWidget {
  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  String storeName = "";
  String address = "";
  TextEditingController addressController = TextEditingController();

  bool _loading = false;

  Position _position;
  UserApi userApi = UserApi.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: kColorWhite,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kColorTransparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClippedWidget(
                text: 'Your store',
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter store name',
                  icon: Icons.store,
                  obscureText: false,
                  onChanged: (value) {
                    storeName = value;
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
                  label: 'Continue',
                  onPressed: () async {
                    if (storeName.isNotEmpty && _position != null) {
                      setState(() {
                        _loading = true;
                      });
                      Store store = Store(
                        ownerEmail: userApi.email,
                        ownerContact: userApi.phoneNo,
                        ownerName: '${userApi.firstName} ${userApi.lastName}',
                        name: storeName,
                        latitude: _position.latitude,
                        longitude: _position.longitude,
                        address: address,
                        rating: 0,
                        reviews: 0,
                        orders: 0,
                      );
                      await createStore(store);
                      setState(() {
                        _loading = false;
                      });
                    } else {
                      AlertBox.showMessageDialog(
                          context, 'Error', 'Please fill up all the fields!');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> createStore(Store store) async {

    Map<String,dynamic> data = {
      'name' : store.name,
      'ownerContact' : store.ownerContact,
      'ownerName' : store.ownerName,
      'ownerEmail' : store.ownerEmail,
      'latitude' : store.latitude,
      'longitude' : store.longitude,
      'address' : store.address,
      'rating' : store.rating,
      'reviews' : store.reviews,
    };

    // ignore: deprecated_member_use
    await Firestore.instance.collection('Sellers')
        .doc(userApi.email)
        .set(data).then((value) async {

          // Save all the data in store api class
          StoreApi storeApi = StoreApi.instance;
          storeApi.name = store.name;
          storeApi.ownerName = store.ownerName;
          storeApi.ownerEmail = store.ownerEmail;
          storeApi.ownerContact = store.ownerContact;
          storeApi.latitude = store.latitude;
          storeApi.longitude = store.longitude;
          storeApi.address = store.address;
          storeApi.rating = store.rating;
          storeApi.reviews = store.reviews;
          storeApi.orders = store.orders;

          await AlertBox.showMessageDialog(context, 'Success', 'Registered as a seller successfully');

          Navigator.pop(context,'SUCCESS');
    }).catchError((error){
      AlertBox.showMessageDialog(context, 'Error','Unable to create store.\n${error.message}');
    });
  }
}
