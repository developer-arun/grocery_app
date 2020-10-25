
class Booking {

  //CREATING A BOOKING CLASS
  String id;
  double fromLat;
  double fromLong;
  double toLat;
  double toLong;
  String buyerEmail;
  String sellerEmail;
  String storeName;
  String productId;
  double quantity;
  double price;
  String status;
  String timestamp;

  Booking({this.id, this.fromLat, this.fromLong, this.toLat, this.toLong,
      this.buyerEmail, this.sellerEmail, this.storeName, this.productId,
      this.quantity, this.price,this.status,this.timestamp});


}
