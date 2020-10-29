import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Model/CartProduct.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/cart_page.dart';
import 'package:grocery_app/Screens/Review&Rating/add_review_screen.dart';
import 'package:grocery_app/Services/cart_service.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();

  final Product product;
  final bool fromCart;
  final String productId;

  const ProductScreen(
      {@required this.product,
      @required this.fromCart,
      @required this.productId});
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  double currentSelected = 0;
  bool _loadedProduct = false;
  Uri _emailLaunchUri;

  Product _product;

  Future loadProduct() async {
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(widget.productId)
        .get()
        .then((element) {
      _product = Product(
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
      );

      initializeData();

      setState(() {
        _loadedProduct = true;
      });
    }).catchError((error) {
      AlertBox.showMessageDialog(
          context, 'Error', 'Error loading product details\n$error');
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      _loadedProduct = true;
      _product = widget.product;
      initializeData();
    } else {
      loadProduct();
    }

    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<Offset>(
            begin: Offset(0, widget.fromCart ? 1.2 : 1), end: Offset(0, 0))
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.3,
          1,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    controller.forward();
  }

  void initializeData() {
    _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _product.ownerEmail,
    );

    if (CartService.cartProducts[_product.id] != null) {
      currentSelected = CartService.cartProducts[_product.id].quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loadedProduct
        ? Scaffold(
            backgroundColor: kColorWhite,
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
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    // TODO:CODE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          leadingWidget: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: widget.fromCart ? '${_product.id}cart' : _product.id,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 2 / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            _product.imageURL,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: animation,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 50),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kColorWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                _product.name,
                                style: TextStyle(
                                    fontSize: 36,
                                    color: kColorPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '₹',
                                  style: TextStyle(
                                    color: kColorPurple,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${_product.price}',
                                      style: TextStyle(
                                        color: kColorPurple,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/Kg',
                                      style: TextStyle(
                                        color: kColorPurple,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            _product.desc,
                            style: TextStyle(
                              color: kColorPurple.withOpacity(0.3),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '⭐ ${_product.rating}',
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Product By',
                            style: TextStyle(
                              fontSize: 20,
                              color: kColorPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                _product.ownerEmail,
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch(_emailLaunchUri.toString());
                                },
                                child: Icon(
                                  Icons.mail,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButtonWidget(
                            label: 'View Reviews',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RatingReviewScreen(
                                    productId: _product.id,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'In stock: ${_product.quantity} Kg',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (currentSelected > 0) {
                                            setState(() {
                                              currentSelected -= 0.25;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: kColorPurple,
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: '$currentSelected',
                                            style: TextStyle(
                                              color: kColorPurple,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Kg',
                                                style: TextStyle(
                                                  color: kColorPurple,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (currentSelected <
                                              _product.quantity) {
                                            setState(() {
                                              currentSelected += 0.25;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          color: kColorPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomButtonWidget(
                                  label:
                                      CartService.cartProducts[_product.id] ==
                                              null
                                          ? 'Add to cart'
                                          : 'Update Cart',
                                  onPressed: () {
                                    // Checking if the cart already contains products from same store or is empty
                                    // Checking the quantity of products
                                    if (currentSelected == 0) {
                                      CartService.sellerId = null;
                                      CartService.cartProducts[_product.id] =
                                          null;
                                    } else {
                                      if (CartService.sellerId ==
                                              _product.ownerEmail ||
                                          CartService.sellerId == null) {
                                        CartService.sellerId =
                                            _product.ownerEmail;
                                        CartService.cartProducts[_product.id] =
                                            CartProduct(
                                          discount: 0,
                                          product: _product,
                                          quantity: currentSelected,
                                          totalCost:
                                              currentSelected * _product.price,
                                        );
                                      } else {
                                        // Displaying error if cart contains products from a different store
                                        AlertBox.showMessageDialog(
                                            context,
                                            'Error',
                                            'Cannot add items from two different stores! Please empty the cart first.');
                                      }
                                    }

                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : ModalProgressHUD(
            inAsyncCall: true,
            color: kColorWhite,
            child: Container(),
          );
  }
}
