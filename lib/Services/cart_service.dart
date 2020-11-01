import 'package:grocery_app/Model/CartProduct.dart';

class CartService{

  static String sellerId;
  static Map<String,CartProduct> cartProducts = {};
  static double discount = 0;
  static String offerId;
}