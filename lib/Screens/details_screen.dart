import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/review_card.dart';
import 'package:grocery_app/clipper/waveclipper.dart';
import 'package:grocery_app/utilities/constants.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count=0;
  double star=3,price=1.99,quantity=1;
  String productName="Apple",storeName="Store A",address="Svbh",
      ProductImageurl="https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      StoreImageurl="https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      description="finest quality apples from kashmir";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
                  color: kColorPurple,
                  boxShadow:[ BoxShadow(
                        color: Colors.pink[100],
                    blurRadius: 2,
                    spreadRadius: 1
                  )],
                  image:  DecorationImage(
                    colorFilter: ColorFilter.mode(kColorPurple.withOpacity(0.5), BlendMode.srcATop),
                    fit: BoxFit.cover,
                      image: NetworkImage(ProductImageurl),   ),
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: (){
                            //TODO add method to goto previous screen
                          },
                          iconSize: 20,
                          splashColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: Text(productName,style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                child: Text("Product Specifications",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: kColorPurple.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.red,blurRadius: 0.0,spreadRadius: 1),
                              ]
                          ),
                          child: Text(
                            '$quantity kg',
                            style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Price',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.green,blurRadius: 0.0,spreadRadius: 1),
                              ]
                          ),
                          child: Text(
                            '\$ $price',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(StoreImageurl),
                    radius: 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(storeName,style: TextStyle(fontSize: 15,color: kColorPurple),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.store,color: kColorPurple,),
                      ),
                    ],
                  )

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.location_on,color: kColorPurple,),
                ),
                Text(address),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                child: Text("Product Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: kColorPurple.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                child: Text(description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: kColorPurple,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                child: Text("Rating",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: kColorPurple.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 1
                  )]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("$star",style: TextStyle(fontSize: 15,color: Colors.redAccent,fontWeight: FontWeight.bold),),
                    StarDisplay(star*10),
                    StarDisplay(star*10-10),
                    StarDisplay(star*10-20),
                    StarDisplay(star*10-30),
                    StarDisplay(star*10-40),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Text("Reviews",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: kColorPurple.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
                  color: Colors.white,
                  boxShadow:[ BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 2,
                      spreadRadius: 2
                  )],
              ),
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),

                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),

                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),

                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),
                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),
                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),
                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),
                      ReviewCard(user: "Anubhav",imageurl: "https://images.pexels.com/photos/89778/strawberries-frisch"
                          "-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",review: "Mast hai bhai lele",),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height*0.09,
        child: Material(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.purpleAccent,Colors.pink
                            ]
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 27,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        if(count<=0)
                        {
                          setState(() {
                            count=0;
                          });
                        }
                        else
                          setState(() {
                            --count;
                          });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                            Icons.remove_circle_outline,
                            size: 30,
                            color: Colors.pink),
                      ),
                    ),
                    Container(),
                    GestureDetector(
                      onTap: (){
                        //todo add the data to cart
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: Colors.pink),

                      ),
                    ),
                    Container(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          ++count;
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                            Icons.add_circle_outline,
                            size: 30,
                            color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10.0,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "-1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Container(),
                    Text(
                      "$count",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Container(),
                    Text(
                      "+1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),),
    );
  }
  Widget StarDisplay(double star)
  {
    int i=star.toInt();
    if(i>0)
        {
          if(i<10)
            return Icon(Icons.star_half,color: Colors.yellow[700],size: 20,);
          if(i>=10)
            return Icon(Icons.star,color: Colors.yellow[700],size: 20,);
        }
      else
        {
          return Icon(Icons.star,color: Colors.grey[400],size: 20,);
        }
  }
}
