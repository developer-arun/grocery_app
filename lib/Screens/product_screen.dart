import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();

  final Product product;

  const ProductScreen({@required this.product});
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<Offset>(begin: Offset(0,1),end: Offset(0,0)).animate(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: widget.product.id,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 2/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.product.imageURL,
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
                padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
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
                          widget.product.name,
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
                                text: '${widget.product.price}',
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
                      widget.product.desc,
                      style: TextStyle(
                        color: kColorPurple.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '⭐ ${widget.product.rating}',
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
                          widget.product.ownerEmail,
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO:CODE
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
                        // TODO : CODE
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'In stock: ${widget.product.quantity} Kg',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.remove_circle_outline,
                                  color: kColorPurple,
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: '0',
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
                                Icon(
                                  Icons.add_circle_outline,
                                  color: kColorPurple,
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
                            label: 'Add to cart',
                            onPressed: () {
                              // TODO:CODE
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
    );
  }
}
