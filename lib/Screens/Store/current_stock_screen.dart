import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/Components/stock_item_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/constants.dart';

class CurrentStockScreen extends StatefulWidget {
  @override
  _CurrentStockScreenState createState() => _CurrentStockScreenState();
}

class _CurrentStockScreenState extends State<CurrentStockScreen> {
  bool displayCurrentStock = false;
  List<Product> currentStock = [];

  void getCurrentStock() async {
    currentStock = await DatabaseServices.getCurrentStock();
    displayCurrentStock = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getCurrentStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Current Stock',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 26,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: displayCurrentStock
              ? (currentStock.isNotEmpty
                  ? StaggeredGridView.countBuilder(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: currentStock.length,
                      itemBuilder: (BuildContext context, int index) =>
                          new StockItemWidget(
                            product: currentStock[index],
                          ),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 2.5 : 3),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    )
                  : Center(
                      child: Text(
                        'Nothing to display',
                        style: TextStyle(
                          color: kColorPurple.withOpacity(0.4),
                        ),
                      ),
                    ))
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
