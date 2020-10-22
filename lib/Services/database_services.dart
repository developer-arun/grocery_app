import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/user_api.dart';

class DatabaseServices {
  /*
  Function to fetch products belonging to a particular category from database
  Products displayed should be in user's city
   */
  static Future<List<Product>> getProductsByCategory(String category) async {
    List<Product> products = [];
    var firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("Products")
        .where("category", isEqualTo: category)
        .where("city", isEqualTo: UserApi.instance.getCity())
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .get()
        .then((result) {
      for (var element in result.docs) {
        products.add(Product(
          id: element.data()["itemId"],
          name: element.data()["name"],
          desc: element.data()["description"],
          ownerEmail: element.data()["storeId"],
          price: element.data()["price"],
          quantity: element.data()["quantity"],
          rating: element.data()["rating"],
          reviews: element.data()["reviews"],
          orders: element.data()["orders"],
          imageURL: element.data()["imageurl"],
          category: element.data()["category"],
          timestamp: int.parse(element.data()["timestamp"]),
          city: UserApi.instance.getCity(),
          country: UserApi.instance.getCountry(),
        ));
      }
    }).catchError((error) {
      print(error);
    });

    return products;
  }
}
