import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/utilities/booking_status.dart';
import 'package:grocery_app/utilities/task_status.dart';
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
    presentstamp = presentstamp - (24 * 3600 * 1000);

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
      store = Store(
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
        country: value.data()['country'],
        city: value.data()['city'],
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
        .orderBy("rating", descending: true)
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

  /*
  Function to fetch seller's details in user's city and country from database
  in decreasing order of rating
   */
  static Future<List<Store>> getSellerByRating() async {
    List<Store> store = [];
    var firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("Sellers")
        .where("city",
            isEqualTo: (UserApi.instance)
                .getCity()) //fetching top 5 rating stores details
        .where("country", isEqualTo: UserApi.instance.getCountry())
        .orderBy("rating", descending: true)
        .limit(5)
        .get()
        .then((result) {
      for (var element in result.docs) {
        store.add(Store(
          name: element.data()["name"],
          ownerEmail: element.data()["ownerEmail"],
          ownerName: element.data()["ownerName"],
          ownerContact: element.data()["ownerContact"],
          rating: element.data()["rating"],
          reviews: element.data()["reviews"],
          address: element.data()["address"],
          latitude: element.data()["latitude"],
          longitude: element.data()["longitude"],
          orders: element.data()["orders"],
          city: UserApi.instance.getCity(),
          country: UserApi.instance.getCountry(),
        ));
      }
    }).catchError((error) {
      print(error);
    });
    return store;
  }

  /*
  Function to order a product
   */
  static Future<String> orderProducts(List<Booking> bookings) async {
    for (Booking booking in bookings) {
      final DocumentReference documentReference = await FirebaseFirestore
          .instance
          .collection('Bookings')
          .add(new Map<String, dynamic>())
          .catchError((error) {
        return error.message.toString();
      });

      Map<String, dynamic> data = {
        'id': documentReference.id,
        'fromLat': booking.fromLat,
        'fromLong': booking.fromLong,
        'toLat': booking.toLat,
        'toLong': booking.toLong,
        'buyerEmail': booking.buyerEmail,
        'sellerEmail': booking.sellerEmail,
        'storeName': booking.storeName,
        'productId': booking.productId,
        'quantity': booking.quantity,
        'price': booking.price,
        'status': booking.status,
        'timestamp': booking.timestamp,
      };

      await FirebaseFirestore.instance
          .collection('Bookings')
          .doc(documentReference.id)
          .set(data)
          .then((value) => {})
          .catchError((error) {
        return error.message.toString();
      });
    }
    return TaskStatus.SUCCESS.toString();
  }

  /*
  Function to fetch booking details of a user from database
  in decreasing order of timestamp
   */
  static Future<List<Booking>> getBooking() async {
    List<Booking> booking = [];
    var firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("Bookings")
        .where("buyerEmail", isEqualTo: (UserApi.instance).email)
        .where("status",isEqualTo: BookingStatus.PENDING.toString())
        .orderBy("timestamp", descending: true)
        .get()
        .then((result) {
      for (var element in result.docs) {
          booking.add(Booking(
          id: element.data()["id"],
          fromLat: element.data()["fromLat"],
          fromLong: element.data()["fromLong"],
          toLat: element.data()["toLat"],
          toLong: element.data()["toLong"],
          buyerEmail: element.data()["buyerEmail"],
          sellerEmail: element.data()["sellerEmail"],
          storeName: element.data()["storeName"],
          productId: element.data()["productId"],
          price: element.data()["price"],
          status: element.data()["status"],
          quantity: element.data()["quantity"],
          timestamp: element.data()["timestamp"]
        ));
      }
    }).catchError((error) {
      print(error);
    });


    await firestoreInstance
        .collection("Bookings")
        .where("buyerEmail", isEqualTo: (UserApi.instance).email)
        .where("status",isEqualTo: BookingStatus.CONFIRMED.toString())
        .orderBy("timestamp", descending: true)
        .get()
        .then((result) {
      for (var element in result.docs) {
        booking.add(Booking(
            id: element.data()["itemId"],
            fromLat: element.data()["fromLat"],
            fromLong: element.data()["fromLong"],
            toLat: element.data()["toLat"],
            toLong: element.data()["toLong"],
            buyerEmail: element.data()["buyerEmail"],
            sellerEmail: element.data()["sellerEmail"],
            storeName: element.data()["storeName"],
            productId: element.data()["productId"],
            price: element.data()["price"],
            status: element.data()["status"],
            quantity: element.data()["quantity"],
            timestamp: element.data()["timestamp"]
        ));
      }
    }).catchError((error) {
      print(error);
    });
    return booking;
  }
}
