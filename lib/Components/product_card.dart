import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Screens/Shopping/product_screen.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  const ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductScreen(
                  product: product,
                  fromCart: false,
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorPurple.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: product.id,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image:
                        NetworkImage(product.imageURL),
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
              flex: 2,
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 24,
                              color: kColorPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.desc,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                              kColorPurple.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment:
                        WrapCrossAlignment.end,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            '⭐ ${product.rating}',
                          ),
                          Text(
                            '₹ ${product.price}',
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
    );
  }
}
