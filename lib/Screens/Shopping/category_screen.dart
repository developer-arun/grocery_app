import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/product_card.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Screens/Home/Navigation_Pages/cart_page.dart';
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
  List<Product> filteredProducts = [];
  bool _filterApplied = false;

  bool dataLoaded = false;

  void loadProducts() async {
    products = await DatabaseServices.getProductsByCategory(widget.category);
    dataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {

    List<Product> displayProducts = filteredProducts;

    if (_filterApplied != true) {
      displayProducts = products;
    }

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: kColorPurple,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: dataLoaded
          ? Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextInputWidget(
                    icon: Icons.search,
                    obscureText: false,
                    hint: "Search from loaded products",
                    onChanged: (value) {
                      String filter = value.toString().trim();
                      if (filter.isNotEmpty) {
                        _filterApplied = true;
                        filteredProducts = products
                            .where((product) =>
                                product.name.toLowerCase().contains(filter))
                            .toList();
                      } else {
                        _filterApplied = false;
                      }
                      setState(() {});
                    },
                  ),
                ),
                displayProducts.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: displayProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 0),
                              child: ProductCard(
                                product: displayProducts[index],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Nothing to display',
                          style: TextStyle(
                            color: kColorPurple.withOpacity(0.4),
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
