import 'package:flutter/material.dart';

import 'constants.dart';

class AlertBox {
  static Future<void> showMessageDialog(
      BuildContext context, String title, String message) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: kColorPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                message,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: kColorPurple,
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
