import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/store_api.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:grocery_app/utilities/categories.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String itemName = "",
      description = "",
      imageurl = "",
      category = "Choose category";
  double price = 0, quantity = 0;
  bool _loading = false;

  File _productImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: kColorTransparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClippedWidget(
              text: 'Add new product to your store',
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextInputWidget(
                hint: 'Enter name of product',
                icon: Icons.fastfood,
                obscureText: false,
                onChanged: (value) {
                  itemName = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextInputWidget(
                hint: 'Enter product details',
                icon: Icons.details,
                obscureText: false,
                onChanged: (value) {
                  description = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextInputWidget(
                hint: 'Enter quantity of product',
                icon: Icons.assignment_turned_in,
                obscureText: false,
                textInputType: TextInputType.number,
                onChanged: (value) {
                  quantity = double.parse(value);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextInputWidget(
                hint: 'Enter price of product',
                icon: Icons.attach_money,
                obscureText: false,
                textInputType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: kColorPurple.withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.category,
                              color: kColorPurple,
                            ),
                            SizedBox(width: 17),
                            Text(
                              category,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: category == "Choose category"
                                    ? Colors.grey[400]
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          color: category == "Choose category"
                              ? Colors.white
                              : kColorPurple,
                          onPressed: category == "Choose category"
                              ? null
                              : () {
                                  setState(() {
                                    category = "Choose category";
                                  });
                                },
                        )
                      ],
                    ))),
            SizedBox(
              height: 5,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category = Categories.availableCategories[0];
                      });
                    },
                    child: Text(
                      Categories.availableCategories[0],
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.purple[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category =
                            Categories.availableCategories[1];
                      });
                    },
                    child: Text(
                      Categories.availableCategories[1],
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category = Categories.availableCategories[2];
                      });
                    },
                    child: Text(
                      Categories.availableCategories[2],
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.indigo[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category = Categories.availableCategories[3];
                      });
                    },
                    child: Text(
                      Categories.availableCategories[3],
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.transparent,
                  color: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      category =
                          Categories.availableCategories[4];
                    });
                  },
                  child: Text(
                    Categories.availableCategories[4],
                    style: TextStyle(
                      color: Colors.pink[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      category =
                          Categories.availableCategories[5];
                    });
                  },
                  child: Text(
                    Categories.availableCategories[5],
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  color: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      category = Categories.availableCategories[6];
                    });
                  },
                  child: Text(
                    Categories.availableCategories[6],
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _productImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: FileImage(_productImage),
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: kColorPurple.withOpacity(0.1),
                              blurRadius: 1,
                              spreadRadius: 1,
                            )
                          ]),
                      child: Text(
                        "Choose image for your product",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    color: kColorPurple,
                    iconSize: 25,
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_library,
                      color: kColorPurple,
                    ),
                    iconSize: 25,
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: CustomButtonWidget(
                label: "Add Product",
                onPressed: () async {
                  if (itemName.isNotEmpty &&
                      description.isNotEmpty &&
                      category != "Choose category" &&
                      price != 0 &&
                      quantity != 0) {
                    setState(() {
                      _loading = true;
                    });
                    Product product = Product(
                      quantity: quantity,
                      name: itemName,
                      desc: description,
                      price: price,
                      category: category,
                      ownerEmail: StoreApi.instance.ownerEmail,
                      reviews: 0,
                      rating: 0,
                      orders: 0,
                    );
                    await addProductDetails(
                      product: product,
                      context: context,
                    );
                  } else {
                    AlertBox.showMessageDialog(
                        context, 'Error', 'Please fill up all the fields!');
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _productImage = File(pickedFile.path);
      }
    });
  }

  Future addProductDetails({Product product, BuildContext context}) async {
    final DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('Products')
        .add(new Map<String, dynamic>())
        .catchError((error) {
      AlertBox.showMessageDialog(context, 'Error',
          'An error occurred in saving user data\n${error.message}');
      return;
    });

    StorageReference ref = FirebaseStorage()
        .ref()
        .child('ProductImages')
        .child(documentReference.id);
    final StorageUploadTask storageUploadTask = ref.putFile(_productImage);

    String imageurl = "";
    imageurl = await (await storageUploadTask.onComplete).ref.getDownloadURL();

    UserApi userApi = UserApi.instance;

    // TODO: PRODUCT DATA MAP
    Map<String, dynamic> data = {
      "itemId": documentReference.id,
      "storeId": product.ownerEmail,
      "name": product.name,
      "quantity": product.quantity,
      "price": product.price,
      "reviews": product.reviews,
      "rating": product.rating,
      "category": product.category,
      "orders": product.orders,
      "description": product.desc,
      "imageurl": imageurl,
      "timestamp": (new DateTime.now().millisecondsSinceEpoch).toString(),
      "city": userApi.getCity(),
      "country": userApi.getCountry(),
    };

    FirebaseFirestore.instance
        .collection("Products")
        .doc(data['itemId'])
        .set(data)
        .then((value) async {
      await AlertBox.showMessageDialog(
          context, 'Success', 'User details stored successfully!');
      setState(() {
        _loading = false;
      });
      Navigator.pushReplacementNamed(context, '/addItem');
    }).catchError((error) {
      AlertBox.showMessageDialog(context, 'Error',
          'An error occurred in saving user data\n${error.message}');
    });
  }
}
