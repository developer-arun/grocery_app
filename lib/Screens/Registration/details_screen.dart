import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/components/clipped_widget.dart';
import 'package:grocery_app/components/custom_button_widget.dart';
import 'package:grocery_app/components/text_input_widget.dart';
import 'package:grocery_app/utilities/constants.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClippedWidget(
              text: 'Tell us more about you',
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: TextInputWidget(
                hint: 'Enter first name',
                icon: Icons.person,
                obscureText: false,
                onChanged: (value){
                  // TODO:CODE
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: TextInputWidget(
                hint: 'Enter last name',
                icon: Icons.person,
                obscureText: false,
                onChanged: (value){
                  // TODO:CODE
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: TextInputWidget(
                hint: 'Enter phone number',
                icon: Icons.call,
                obscureText: false,
                textInputType: TextInputType.number,
                onChanged: (value){
                  // TODO:CODE
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: TextInputWidget(
                hint: 'Enter address',
                icon: Icons.location_on,
                obscureText: false,
                onChanged: (value){
                  // TODO:CODE
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: CustomButtonWidget(
                label: 'Continue',
                onPressed: (){
                  // TODO:CODE
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}



