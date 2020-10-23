// This class will be used to store all the store data, which will be available globally within the app

class StoreApi {

  StoreApi._privateConstructor();

  static final StoreApi _instance = StoreApi._privateConstructor();
  static StoreApi get instance => _instance;

  String _name;
  String _ownerEmail;
  String _ownerName;
  String _ownerContact;
  double _rating;
  int _reviews;
  String _address;
  double _latitude;
  double _longitude;
  int _orders;
  String _city;
  String _country;


  String get city => _city;

  set city(String value) {
    _city = value;
  }

  int get orders => _orders;

  set orders(int value) {
    _orders = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get ownerEmail => _ownerEmail;

  set ownerEmail(String value) {
    _ownerEmail = value;
  }

  String get ownerName => _ownerName;

  set ownerName(String value) {
    _ownerName = value;
  }

  String get ownerContact => _ownerContact;

  set ownerContact(String value) {
    _ownerContact = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  int get reviews => _reviews;

  set reviews(int value) {
    _reviews = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }


}