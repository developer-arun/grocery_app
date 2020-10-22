import 'package:grocery_app/Model/Product.dart';

class CartProduct{
  Product product;
  double quantity;
  double discount;
  double totalCost;

  CartProduct({this.product, this.quantity, this.discount, this.totalCost});


}