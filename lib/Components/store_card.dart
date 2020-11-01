import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Store.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({@required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: kColorPurple.withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 1),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                store.name,
                style: TextStyle(
                  color: kColorPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '⭐ ${store.rating}',
                style: TextStyle(
                    color: kColorPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            store.ownerEmail,
            style: TextStyle(
              color: kColorPurple.withOpacity(0.4),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.directions,
                  color: kColorPurple,
                ),
                onPressed: () {
                  launch(
                      'https://www.google.com/maps/search/?api=1&query=${store.latitude},${store.longitude}');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.call,
                  color: kColorPurple,
                ),
                onPressed: () {
                  final Uri _launchUri = Uri(
                    scheme: 'tel',
                    path: store.ownerContact,
                  );
                  launch(_launchUri.toString());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.mail,
                  color: kColorPurple,
                ),
                onPressed: () {
                  final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: store.ownerEmail,
                  );
                  launch(_emailLaunchUri.toString());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
