import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Screens/Shopping/product_screen.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProductsPager extends StatefulWidget {
  @override
  _ProductsPagerState createState() => _ProductsPagerState();
}

class _ProductsPagerState extends State<ProductsPager> {
  List<Product> products = [];
  bool _loading = true;
  void getProducts() async {
    _loading = true;
    products = await DatabaseServices.getProductsByRating();
    _loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: _loading == false ? (
          products.length > 0 ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            product: products[index],
                            fromCart: true,
                            productId: null,
                          ),
                        ),
                      );
                    },
                    child: Material(
                      color: kColorWhite,
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              products[index].imageURL,
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                kColorPurple.withOpacity(0.5), BlendMode.srcATop),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: kColorPurple.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            products[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kColorWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ) :   Center(
            child: Text(
              'No products found in your city',
              style: TextStyle(
                  color: kColorPurple.withOpacity(0.4), fontSize: 20),
            ),
          )
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
