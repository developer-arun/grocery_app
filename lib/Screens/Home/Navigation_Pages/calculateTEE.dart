import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/clipped_widget.dart';
import 'package:grocery_app/Components/custom_button_widget.dart';
import 'package:grocery_app/Components/text_input_widget.dart';
import 'package:grocery_app/utilities/alert_box.dart';
import 'package:grocery_app/utilities/constants.dart';

class CalculateTEE extends StatefulWidget {
  @override
  _CalculateTEEState createState() => _CalculateTEEState();
}

class _CalculateTEEState extends State<CalculateTEE> {
  int _age=0;
  double _weight=0.0;
  double _height=0.0;
  int _selectedradio;       //Radiobutton for gender
  int _selectedradio2;      //Radiobutton for Physical activity intensity
  double _PA;
  double _TEE;
  @override
  void initState() {
    super.initState();
    _selectedradio=1;
    _selectedradio2=1;
  }
  setSelectedRadio(int val){            //function for getting the gender
    setState(() {
      _selectedradio=val;
    });
  }
  setSelectedRadio2(int val){           //function for getting the Physical activity intensity
    setState(() {
      _selectedradio2=val;
    });
  }

  calculateTEE(int gender){                //function for calculating calories
    if(_age!=0&&_weight!=0.0&&_height!=0.0) {
      if (gender == 1) {
        _TEE = 864 - 9.72 * _age.toDouble() +
            _PA * (14.2 * _weight + 503 * _height);
      }
      else {
        _TEE = 387 - 7.31 * _age.toDouble() +
            _PA * (10.9 * _weight + 660.7 * _height);
      }
    }
    else
      {
        AlertBox.showMessageDialog(context, "Error", "Present a valid value");
      }
  }


  calculatePA()                       //function for caluclating physical activity
  {
    if(_selectedradio==1)
      {
        if(_selectedradio2==1)
          {
          _PA=1.0;
          }
        else if(_selectedradio2==2)
          {
            _PA=1.12;
          }
        else if(_selectedradio2==3)
        {
          _PA=1.27;
        }
        else if(_selectedradio2==4)
        {
          _PA=1.54;
        }
      }
    else
    {
      if(_selectedradio2==1)
      {
        _PA=1.0;
      }
      else if(_selectedradio2==2)
      {
        _PA=1.14;
      }
      else if(_selectedradio2==3)
      {
        _PA=1.27;
      }
      else if(_selectedradio2==4)
      {
        _PA=1.45;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClippedWidget(
              text:"Caculate TEE",
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextInputWidget(
                      hint: "Enter age",
                      icon: Icons.person,
                      obscureText: false,
                      onChanged: (value) {
                        _age = int.parse(value);
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextInputWidget(
                      hint: 'Enter your height(in metres',
                      obscureText: false,
                      onChanged: (value) {
                        _height = double.parse(value);
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextInputWidget(
                      hint: 'Enter your weight(in Kgs)',
                      obscureText: false,
                      onChanged: (value) {
                        _weight = double.parse(value);
                      },),
                    SizedBox(height: 15.0),
                    Text(
                      "Gender",
                      style: TextStyle(
                        color: kColorPurple,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
//                    SizedBox(height: 10.0),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _selectedradio,
                              activeColor: Colors.deepPurple,
                              onChanged: (val){                 //selecting the gender
                                setSelectedRadio(val);
                              },
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _selectedradio,
                              activeColor: Colors.deepPurple,
                              onChanged: (val){
                                setSelectedRadio(val);
                              },
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Physical Activity Intensity",
                      style: TextStyle(
                          color: kColorPurple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
//                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _selectedradio2,
                                activeColor: Colors.deepPurple,
                                onChanged: (val){
                                  setSelectedRadio2(val);
                                },
                              ),
                              Text(
                                "Sedentary",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _selectedradio2,
                                activeColor: Colors.deepPurple,
                                onChanged: (val){
                                  setSelectedRadio2(val);
                                },
                              ),
                              Text(
                                "Low active",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _selectedradio2,
                                activeColor: Colors.deepPurple,
                                onChanged: (val){                  //selecting the physical activity intensity
                                  setSelectedRadio2(val);
                                },
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 4,
                                groupValue: _selectedradio2,
                                activeColor: Colors.deepPurple,
                                onChanged: (val){
                                  setSelectedRadio2(val);
                                },
                              ),
                              Text(
                                "Very Active",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButtonWidget(
              label: "Calculate Calories",
              onPressed: (){
                calculatePA();
                calculateTEE(_selectedradio);
                print(_TEE);
              },
            )
          ],
        ),
      ),

    );
  }
}
