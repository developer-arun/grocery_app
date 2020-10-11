import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/utilities/alert_box.dart';

class LocationService{

  // Function to fetch user's current location
  static Future<Position> getCurrentLocation({BuildContext context}) async {
    Position position;
    bool isLocationEnabled = await isLocationServiceEnabled();
    if(isLocationEnabled){
      position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }else{
      AlertBox.showMessageDialog(context, 'Error','Please turn on location services');
    }
    return null;
  }

  // Function to fetch user's address from his location
  static Future<String> getPlace(Position position) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    return address;
  }

}