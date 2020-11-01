import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Offer.dart';
import 'package:grocery_app/Services/cart_service.dart';
import 'package:grocery_app/Services/database_services.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';

class AdvertisementPager extends StatefulWidget {
  @override
  _AdvertisementPagerState createState() => _AdvertisementPagerState();
}

class _AdvertisementPagerState extends State<AdvertisementPager> {
  List<Offer> offers = [];
  bool _loading = true;

  void getOffers() async {
    _loading = true;
    offers = await DatabaseServices.getOffers();
    _loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: _loading == false
          ? (offers.length > 0
              ? PageView.builder(
                  itemCount: offers.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        if (CartService.offerId != offers[index].offerId) {
                          final value = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      Text('Apply offer for next purchase?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              });

                          if (value) {
                            CartService.discount = offers[index].discount;
                          }
                        } else {
                          AlertBox.showMessageDialog(
                              context, 'Error', 'One offer is already in use.');
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  kColorPurple.withOpacity(0.5),
                                  BlendMode.srcATop),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kColorPurple.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${offers[index].name}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: kColorWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${offers[index].discount * 100}% off',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kColorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No offers available',
                    style: TextStyle(
                        color: kColorPurple.withOpacity(0.4), fontSize: 20),
                  ),
                ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
