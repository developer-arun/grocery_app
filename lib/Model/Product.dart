class Product {

  // TODO : Add more fields

  String name;
  String desc;
  String ownerID_email;
  double price;
  double quantity;
  double rating;
  int reviews;
  int orders;
  String imageURL;
  String category;

  Product({this.quantity,this.price,this.category,this.name,this.desc,this.imageURL,
    this.orders,this.ownerID_email,this.rating,this.reviews});
}

