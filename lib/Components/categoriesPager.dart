import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/Shopping/category_screen.dart';
import 'package:grocery_app/utilities/categories.dart';
import 'package:grocery_app/utilities/constants.dart';

class CategoriesPager extends StatefulWidget {
  @override
  _CategoriesPagerState createState() => _CategoriesPagerState();
}

class _CategoriesPagerState extends State<CategoriesPager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      child: ListView.builder(
        itemCount: Categories.availableCategories.length - 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (buildContext) => CategoryScreen(
                    category: Categories.availableCategories[index],
                  ),
                ),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(
                            'assets/images/categories/${Categories.availableCategories[index]}.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Categories.availableCategories[index],
                      style: TextStyle(
                        color: kColorPurple,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
