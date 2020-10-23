import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/utilities/constants.dart';

class StockItemWidget extends StatelessWidget {

  final Product product;
  const StockItemWidget({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: kColorPurple.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageURL),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kColorPurple,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            child: Text(
              product.name,
              style: TextStyle(
                color: kColorPurple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            child: Text(
              '${product.quantity} Kgs',
              style: TextStyle(
                color: kColorPurple,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}