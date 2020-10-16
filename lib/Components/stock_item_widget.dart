import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class StockItemWidget extends StatelessWidget {
  const StockItemWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 20),
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
                // TODO: ADD DECORATION IMAGE
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
              'Apple',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.redAccent,blurRadius: 0.0,spreadRadius: 1),]
                  ),
                  child: Text(
                    '2 Kg',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.green,blurRadius: 0.0,spreadRadius: 1),
                    ]
                  ),
                  child: Text(
                    '\$ 1.99',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}