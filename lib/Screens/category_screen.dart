import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  final String category;

  const CategoryScreen({@required this.category});
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> products = [];

  void loadProducts() async {
    products = await DatabaseServices.getProductsByCategory(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: kColorPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextInputWidget(
              icon: Icons.search,
              obscureText: false,
              hint: "Search for something",
              onChanged: (value) {
                //TODO:CODE
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Container(
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(products[index].imageURL),
                                  fit: BoxFit.cover,
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
                            aspectRatio: 2/1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        products[index].name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: kColorPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        products[index].desc,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: kColorPurple.withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        '⭐ ${products[index].rating}',
                                      ),
                                      Text(
                                        '₹ ${products[index].price}',
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
