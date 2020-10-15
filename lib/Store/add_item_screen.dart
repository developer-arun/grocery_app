
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
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}
enum _Categoris{Beverages,Bakery,Dairy,Others,Spices,Perishables,FreshProduce}

class _AddItemState extends State<AddItem> {
  String itemName="",
  description="",
  imageurl="",
  category="Choose category";
  double price=0,quantity=0;
  bool _loading = false,imageSelected=false;
  PickedFile _file;
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClippedWidget(
                text: 'Add new product to your store',
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter name of product',
                  icon: Icons.fastfood,
                  obscureText: false,
                  onChanged: (value){
                     itemName=value;
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter product details',
                  icon: Icons.details,
                  obscureText: false,
                  onChanged: (value){
                    description=value;
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter quantity of product',
                  icon: Icons.assignment_turned_in,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  onChanged: (value){
                    quantity=value;
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: TextInputWidget(
                  hint: 'Enter price of product',
                  icon: Icons.attach_money,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  onChanged: (value){
                    price=value;
                  },
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                          Icon(Icons.category,
                          color: kColorPurple,),
                          SizedBox(width:17),
                          Text( category,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: category=="Choose category"?Colors.grey[400]:Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon:  Icon(Icons.clear),
                        color: category=="Choose category"?Colors.white:kColorPurple,
                        onPressed: category=="Choose category"?null:(){
                          setState(() {
                            category="Choose category";
                          });
                        },
                      )
                    ],
                  )
                )
              ),
              SizedBox(height: 5,),
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
                            category=_Categoris.Bakery.toString().split(".")[1];
                          });
                        },
                        child: Text(_Categoris.Bakery.toString().split(".")[1],
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),

                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.purple[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                          setState(() {
                            category=_Categoris.Beverages.toString().split(".")[1];
                          });
                    },
                    child: Text(_Categoris.Beverages.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category=_Categoris.Spices.toString().split(".")[1];
                      });                    },
                    child: Text(_Categoris.Spices.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.indigo[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category=_Categoris.Dairy.toString().split(".")[1];
                      });                    },
                    child: Text(_Categoris.Dairy.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                    ]
                  ),
              SizedBox(height:3),
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
                        category=_Categoris.Perishables.toString().split(".")[1];
                      });                    },
                    child: Text(_Categoris.Perishables.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.pink[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.green[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category=_Categoris.FreshProduce.toString().split(".")[1];
                      });                    },
                    child: Text(_Categoris.FreshProduce.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        category=_Categoris.Others.toString().split(".")[1];
                      });                    },
                    child: Text(_Categoris.Others.toString().split(".")[1],
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              imageSelected?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Text("")//Todo  display image here
                )
              )
                  :Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                              boxShadow: [ BoxShadow(
                        color: kColorPurple.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,)]
                        ),
                              child: Text("Choose image for your product",
                        style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      color: kColorPurple,
                      iconSize: 25,
                      onPressed: (){
                        setState(() {
                          imageSelected=true;
                          _file=ImagePicker.pickImage(source: ImageSource.camera) as PickedFile ;
                        });
                        },
                    ),
                    IconButton(
                        icon: Icon(Icons.photo_library,
                        color: kColorPurple,),
                        iconSize: 25,
                        onPressed: (){
                          setState(() async {
                            imageSelected=true;
                            _file=(await ImagePicker.pickImage(source: ImageSource.gallery)) as PickedFile;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: CustomButtonWidget(label: "Add Product", onPressed: () async {

                  if(itemName.isNotEmpty&&description.isNotEmpty&&category!="Choose category"&&price!=0&&quantity!=0){
                    setState(() {
                      _loading=true;
                    });
                   Product product =Product(
                     quantity: quantity,
                     name: itemName,
                     desc: description,
                     price: price,
                     category: category,
                     ownerID_email: StoreApi.instance.ownerEmail,
                     reviews: 0,
                     rating: 0,
                     orders: 0,
                   );
                    await AddProductDetails(
                      product: product,
                      context: context,
                    );
                  }
                  else{
                    AlertBox.showMessageDialog(context, 'Error', 'Please fill up all the fields!');
                  }

                  }
                ),
              ),
            ],
              )
          ),
        ),
    );
  }

 Future AddProductDetails({Product product, BuildContext context}) async {

    Map<String,dynamic> data={
      "itemId":product.name+"_"+product.ownerID_email,
      "storeId": product.ownerID_email,
      "name":product.name,
      "quantity":product.quantity,
      "price":product.price,
      "reviews":product.reviews,
      "rating":product.rating,
      "category":product.category,
      "orders":product.orders,
      "description":product.desc,
      "imageurl":imageurl,
    };

    //Todo : add proper doc name
    FirebaseFirestore
        .instance
        .collection("Products")
        .doc(product.name+"_"+product.ownerID_email)
        .set(data).then((value) async {
      await AlertBox.showMessageDialog(context, 'Success', 'User details stored successfully!');
      setState(() {
        _loading = false;
      });
      Navigator.pushReplacementNamed(context, '/addItem');

    }).catchError((error){
      AlertBox.showMessageDialog(context, 'Error', 'An error occurred in saving user data\n${error.message}');
    });
 }
}
