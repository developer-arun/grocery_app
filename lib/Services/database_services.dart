import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/utilities/user_api.dart';
class DatabaseServices{
  static FirebaseFirestore _firestoreInstance=FirebaseFirestore.instance;
  /*
  Function to fetch products belonging to a particular category from database
  Products displayed should be in user's city
   */
  static Future<List<Product>> getProductsByCategory({String category}) async {

    /*
    Access city as: userApi.getCity() and country as userApi.getCountry()
     */

    // TODO: ADD CODE HERE
    return null;
  }
  /*
    function too fetch details of all the naerby store
    sorted by their rating
   */
  static Future<List<Store>> getNearByStores() async
  {
    List<Store> list=List<Store>();
      var result=await _firestoreInstance.collection("Sellers")
          .orderBy("rating",descending: true)
          .where("city",isEqualTo: UserApi.instance.getCity())
          .where("country",isEqualTo: UserApi.instance.getCountry())
          .get();
      result.docs.forEach((doc) {
          list.add( Store(
            name: doc.data()['name'],
            ownerName: doc.data()['ownerName'],
            address: doc.data()['address'],
            ownerEmail: doc.data()['ownerEmail'],
            rating: doc.data()['rating']
          ));
      });
      return list;
  }
  /*
  this function will return list of all the products of a particular store
   */
  static Future<List<Product>> getProductsOfStore(String StoreId)
  async {
      List<Product> list=List<Product>();
      var result=await _firestoreInstance.collection("Products")
            .orderBy('rating',descending: true)
            .where("storeId",isEqualTo: StoreId)
            .get();
      result.docs.forEach((doc) {
        list.add(Product(
          name: doc.data()['name'],
          desc: doc.data()['description'],
          category: doc.data()['category'],
          imageURL: doc.data()['imageUrl'],
          itemId: doc.data()['itemId'],
          rating: doc.data()['rating'],
          reviews: doc.data()['reviews'],
          price: doc.data()['price'],
          quantity: doc.data()['quantity'],
        ));
      });
      return list;
  }
}