import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Model/Store.dart';
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

  /*
  Function to fetch products for a particular seller from database
  that were added in the store within a single day
   */
  static Future<List<Product>> getCurrentStock() async {
    var presentstamp = DateTime.now().millisecondsSinceEpoch;
    presentstamp = presentstamp - (24* 3600 * 1000);

    List<Product> product = [];
    var firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("Products")
        .where("storeId", isEqualTo: (UserApi.instance).email)
        .where("timestamp", isGreaterThanOrEqualTo: presentstamp.toString())
        .get()
        .then((result) {
      for (var element in result.docs) {
        product.add(Product(
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
    return product;
  }

  /*
  Function to fetch store details for a particular store from database
  using the store owner's email id.
   */
  static Future<Store> getStoreById(String email) async {
    Store store;
    var firebaseinstance = FirebaseFirestore.instance;
    await firebaseinstance.collection("Sellers").doc(email).get().then((value) {
      store =  Store(
        name: value.data()["name"],
        ownerEmail: value.data()["ownerEmail"],
        ownerName: value.data()["ownerName"],
        ownerContact: value.data()["ownerContact"],
        rating: value.data()["rating"],
        reviews: value.data()["reviews"],
        address: value.data()["address"],
        latitude: value.data()["latitude"],
        longitude: value.data()["longitude"],
        orders: value.data()["orders"],
      );
    });
    return store;
  }


  /*
  Function to fetch products details in user's city and country from database
  in decreasing order of rating
   */
  static Future<List<Product>> getProductsByRating() async {

    List<Product> product = [];
    var firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("Products")
        .where("city", isEqualTo: (UserApi.instance).getCity())
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .orderBy("rating",descending: true)
        .limit(5)
        .get()
        .then((result) {
      for (var element in result.docs) {
        product.add(Product(
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
    return product;
  }

}
