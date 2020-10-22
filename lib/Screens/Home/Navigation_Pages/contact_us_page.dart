import 'package:flutter/material.dart';
import 'package:grocery_app/Model/contibutors.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();

  final Widget leadingWidget;
  const ContactUsPage({@required this.leadingWidget});
}

class _ContactUsPageState extends State<ContactUsPage> {
  List<Contributors> contri = [                  //creating a list of contributors
    Contributors(
        name: "Anubhav Rajput",
        nickname: "Anubhav",
        email: "anubhavrajput1804@gmail.com",
        imageurl: "assets/images/anu.jpg"),
    Contributors(
        name: "Harsh Gyanchandani",
        nickname: "Harsh",
        email: "harsh.gyanchandani@gmail.com",
        imageurl: "assets/images/harsh.jpg"),
    Contributors(
        name: "Arun Kumar",
        nickname: "Arun",
        email: "arun12211kumar@gmail.com",
        imageurl: "assets/images/anu.jpg"),
  ];

  void _launchUrl(String emailid) async {                     //sending help mail
    var url = "mailto:$emailid?subject=Regarding help";
    if (canLaunch(url) != null) {
      await launch(url);
    } else
      throw 'cant launch';
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: kColorPurple,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kColorWhite,
          ),
          backgroundColor: kColorPurple,
          elevation: 0,
          leading: widget.leadingWidget,
          centerTitle: true,
          title: Text(
            'My Cart',
            style: TextStyle(
              color: kColorWhite,
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: Text(
                  'Get in touch',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView.builder(           //creating a listview builder
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage:
                            AssetImage(contri[index].imageurl),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contri[index].name,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      contri[index].email,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.mail,
                                  ),
                                  onPressed: (){
                                    _launchUrl(contri[index].email);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}
