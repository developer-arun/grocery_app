import 'package:flutter/material.dart';
import 'package:grocery_app/Model/Booking.dart';
import 'package:grocery_app/utilities/booking_status.dart';
import 'package:grocery_app/utilities/constants.dart';

import 'custom_button_widget.dart';

class BookingCard extends StatelessWidget {

  final Booking booking;
  const BookingCard({@required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kColorWhite,
        boxShadow: [
          BoxShadow(
            color: kColorPurple.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            booking.productName,
            style: TextStyle(
              color: kColorPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${booking.quantity} Kg',
            style: TextStyle(
              color: kColorPurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Rs ${booking.price}',
            style: TextStyle(
              color: kColorPurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            booking.storeName,
            style: TextStyle(
              color: kColorPurple.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            booking.status == BookingStatus.PENDING.toString() ? 'Pending' : 'Order Confirmed',
            style: TextStyle(
              color: booking.status == BookingStatus.PENDING.toString() ? Colors.red : Colors.green,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  label: 'Cancel',
                  onPressed: (){
                    // TODO : CODE
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButtonWidget(
                  label: 'Track',
                  onPressed: (){
                    // TODO : CODE
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}