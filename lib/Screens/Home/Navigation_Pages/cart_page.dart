import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/Model/CartProduct.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/Screens/Shopping/product_screen.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/booking_status.dart';
import 'package:grocery_app/utilities/task_status.dart';
import 'package:grocery_app/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../search_screen.dart';

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
  bool _loading = false;
  List<CartProduct> cartProducts = CartService.cartProducts.values.toList();

  List<Widget> getCartProducts() {
    List<Widget> list = [];
    totalCost = 0;
    for (CartProduct cartProduct in cartProducts) {
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
                  productId: null,
                ),
              ),
            );
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
  Widget build(BuildContext context) {
    if (storeDetails == null) {
      loadStoreDetails();
    }

    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
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
                                                launch(
                                                    'https://www.google.com/maps/search/?api=1&query=${storeDetails.latitude},${storeDetails.longitude}');
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
                                                final Uri _emailLaunchUri = Uri(
                                                  scheme: 'mailto',
                                                  path: storeDetails.ownerEmail,
                                                );
                                                launch(
                                                    _emailLaunchUri.toString());
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
                                                final Uri _launchUri = Uri(
                                                  scheme: 'tel',
                                                  path:
                                                      storeDetails.ownerContact,
                                                );
                                                launch(_launchUri.toString());
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
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: CustomButtonWidget(
                                label: 'Subscribe To Cart Products',
                                onPressed: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                      2000,
                                    ),
                                    lastDate: DateTime(
                                      2100,
                                    ),
                                    helpText: 'Choose a starting date',
                                    confirmText:
                                        'Our product would be at your door every 7th day after selected date. Click to proceed.',
                                  ).then((DateTime picked) async {
                                    if (picked.year >= DateTime.now().year) {
                                      if (picked.month >=
                                          DateTime.now().month) {
                                        if (picked.day > DateTime.now().day) {
                                          // TODO: ADD SUBSCRIPTION

                                          setState(() {
                                            _loading = true;
                                          });

                                          final timestamp = picked
                                              .millisecondsSinceEpoch
                                              .toString();

                                          List<Booking> booking = [];
                                          for (CartProduct cartProduct
                                              in cartProducts) {
                                            booking.add(Booking(
                                              id: null,
                                              quantity: cartProduct.quantity,
                                              fromLat: storeDetails.latitude,
                                              fromLong: storeDetails.longitude,
                                              toLat: UserApi.instance.latitude,
                                              toLong:
                                                  UserApi.instance.longitude,
                                              storeName: storeDetails.name,
                                              sellerEmail:
                                                  storeDetails.ownerEmail,
                                              buyerEmail:
                                                  UserApi.instance.email,
                                              productId: cartProduct.product.id,
                                              price: cartProduct.totalCost,
                                              status: BookingStatus.PENDING
                                                  .toString(),
                                              timestamp: timestamp,
                                              productName:
                                                  cartProduct.product.name,
                                            ));
                                          }

                                          String result = await DatabaseServices
                                              .subscribeToProducts(booking);

                                          if (result ==
                                              TaskStatus.SUCCESS.toString()) {
                                            CartService.sellerId = null;
                                            CartService.cartProducts = {};
                                            AlertBox.showMessageDialog(
                                                context,
                                                'Success',
                                                'Subscribed to product successfully!');
                                          } else {
                                            AlertBox.showMessageDialog(
                                                context,
                                                'Error',
                                                'Unable to subscribe to product\n$result');
                                          }

                                          setState(() {
                                            _loading = false;
                                          });
                                        } else {
                                          AlertBox.showMessageDialog(
                                              context,
                                              'Error',
                                              'Please select a valid date');
                                        }
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          // TODO: ADD PAYMENT SCREEN

                          setState(() {
                            _loading = true;
                          });

                          final timestamp =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          List<Booking> booking = [];
                          for (CartProduct cartProduct in cartProducts) {
                            booking.add(Booking(
                              id: null,
                              quantity: cartProduct.quantity,
                              fromLat: storeDetails.latitude,
                              fromLong: storeDetails.longitude,
                              toLat: UserApi.instance.latitude,
                              toLong: UserApi.instance.longitude,
                              storeName: storeDetails.name,
                              sellerEmail: storeDetails.ownerEmail,
                              buyerEmail: UserApi.instance.email,
                              productId: cartProduct.product.id,
                              price: cartProduct.totalCost,
                              status: BookingStatus.PENDING.toString(),
                              timestamp: timestamp,
                              productName: cartProduct.product.name,
                            ));
                          }

                          String result =
                              await DatabaseServices.orderProducts(booking);

                          if (result == TaskStatus.SUCCESS.toString()) {
                            CartService.sellerId = null;
                            CartService.cartProducts = {};
                            AlertBox.showMessageDialog(context, 'Success',
                                'Order placed successfully!');
                          } else {
                            AlertBox.showMessageDialog(context, 'Error',
                                'Unable to place order\n$result');
                          }

                          setState(() {
                            _loading = false;
                          });
                        },
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
                    ),
                  ],
                )
              : Center(
                  child: CustomButtonWidget(
                    label: 'Shop Now',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
