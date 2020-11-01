import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/Components/stock_item_widget.dart';
import 'package:grocery_app/Model/Product.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/task_status.dart';

class CurrentStockScreen extends StatefulWidget {
  @override
  _CurrentStockScreenState createState() => _CurrentStockScreenState();
}

class _CurrentStockScreenState extends State<CurrentStockScreen> {
  bool displayCurrentStock = false;
  List<Product> currentStock = [];

  void getCurrentStock() async {
    currentStock = await DatabaseServices.getEntireStock();
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
                          new GestureDetector(
                            onLongPress: () async {
                              final value = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Are you sure you want to remove the product from store?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(false);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(true);
                                          },
                                        ),
                                      ],
                                    );
                                  });

                              if (value) {
                                String result =
                                await DatabaseServices
                                    .removeProductFromStore(
                                    currentStock[index]);
                                if (result ==
                                    TaskStatus.SUCCESS
                                        .toString()) {
                                  currentStock.removeAt(index);
                                  setState(() {});
                                }else{
                                  AlertBox.showMessageDialog(context,'Error', 'Unable to remove product\n$result');
                                }
                              }
                            },
                            child: StockItemWidget(
                              product: currentStock[index],
                            ),
                          ),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 2.5 : 3),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
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
