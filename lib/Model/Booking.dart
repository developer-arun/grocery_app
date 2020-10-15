
class Booking {                                     //CREATING A BOOKING CLASS
  int id;
  double fromlattitude;
  double fromlongitude;
  double tolattitude;
  double tolongitude;
  String buyer;
  String seller;
  String productname;
  double price;
  double quantity;
  String imageurl;

  Booking(
      {String productname, double price, double quantity, String imageurl}) {
    this.productname = productname;
    this.price = price;
    this.quantity = quantity;
    this.imageurl = imageurl;
  }
}
