import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/CartProduct.dart';
import 'package:grocery_app/Model/Store.dart';
import '../../search_screen.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/test1/lib/Screens/Shopping/product_screen.dart';
import 'package:grocery_app/Services/cart_service.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();

  final Widget leadingWidget;

  const CartPage({@required this.leadingWidget});
}

class _CartPageState extends State<CartPage> {
  Store storeDetails;
  double totalCost;

  List<Widget> getCartProducts() {
    List<Widget> list = [];
    totalCost = 0;
    for (CartProduct cartProduct in CartService.cartProducts.values.toList()) {
      totalCost += cartProduct.totalCost - cartProduct.discount;
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductScreen(
                          product: cartProduct.product,
                          fromCart: true,
                        )));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kColorWhite,
              boxShadow: [
                BoxShadow(
                  color: kColorPurple.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: '${cartProduct.product.id}cart',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: NetworkImage(cartProduct.product.imageURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  flex: 5,
                  child: AspectRatio(
                    aspectRatio: 5 / 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cartProduct.product.name,
                            style: TextStyle(
                              fontSize: 24,
                              color: kColorPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '${cartProduct.quantity} Kgs',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kColorPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹ ${cartProduct.totalCost}',
                                style: TextStyle(
                                  color: kColorPurple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  void loadStoreDetails() async {
    if (CartService.sellerId != null) {
      storeDetails = await DatabaseServices.getStoreById(CartService.sellerId);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (storeDetails == null) {
      loadStoreDetails();
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kColorPurple,
          ),
          backgroundColor: kColorWhite,
          elevation: 0,
          leading: widget.leadingWidget,
          centerTitle: true,
          title: Text(
            'My Cart',
            style: TextStyle(
              color: kColorPurple,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: kColorWhite,
        body: CartService.sellerId != null
            ? Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: storeDetails != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        storeDetails.name,
                                        style: TextStyle(
                                            color: kColorPurple,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              storeDetails.address,
                                              style: TextStyle(
                                                color: kColorPurple,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // TODO : LOAD MAP
                                            },
                                            child: Icon(
                                              Icons.location_on,
                                              color: kColorPurple,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            storeDetails.ownerEmail,
                                            style: TextStyle(
                                              color: kColorPurple,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // TODO : MAIL TO
                                            },
                                            child: Icon(
                                              Icons.mail,
                                              color: kColorPurple,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            storeDetails.ownerContact,
                                            style: TextStyle(
                                              color: kColorPurple,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // TODO : PLACE CALL
                                            },
                                            child: Icon(
                                              Icons.call,
                                              color: kColorPurple,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: getCartProducts(),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kColorPurple,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            'Place Order | ₹ $totalCost',
                            style: TextStyle(
                              color: kColorWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CustomButtonWidget(
                  label: 'Shop Now',
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
              ),
      ),
    );
  }
}
