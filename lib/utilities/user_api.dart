// This class will be used to store all the user data, which will be available globally within the app

class UserApi {

  UserApi._privateConstructor();

  static final UserApi _instance = UserApi._privateConstructor();
  static UserApi get instance => _instance;

  String _email;
  String _firstName;
  String _lastName;
  String _address;
  String _phoneNo;
  double _latitude;
  double _longitude;
  bool _isSeller;
  int _orders;
  String _city;
  String _country;

  String getCity(){
    List<String> myList = _address.split(",").toList();
    String city = myList[2].trim();
    return city;
  }

  String getCountry(){
    List<String> myList = _address.split(",").toList();
    String country = myList[4].trim();
    return country;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get phoneNo => _phoneNo;

  set phoneNo(String value) {
    _phoneNo = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  int get orders => _orders;

  set orders(int value) {
    _orders = value;
  }
  bool get isSeller=>_isSeller;
  set isSeller(bool value)
  {
    _isSeller=value;
  }
  
}