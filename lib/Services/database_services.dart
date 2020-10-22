import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/user_api.dart';

class DatabaseServices{

  /*
  Function to fetch products belonging to a particular category from database
  Products displayed should be in user's city
   */
  static Future<List<Product>> getProductsByCategory(String category) async {

    List<Product>product=new List();
    var firestoreInstance=FirebaseFirestore.instance;
    
    var result=await firestoreInstance.collection("Products").where("category",isEqualTo: category).where("city",isEqualTo: UserApi.instance.getCity()).where("country",isEqualTo: UserApi.instance.getCountry()).get();
    result.docs.forEach((element) {
      print(element.data());
      product.add(Product(
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
        timestamp: element.data()["timestamp"],
        city: UserApi.instance.getCity(),
        country: UserApi.instance.getCountry(),
      ));
    });
    return product;  //Returning list of product belonging to a a particular category in user's city

  }

}