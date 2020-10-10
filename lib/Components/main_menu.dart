import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Components/menuButtons.dart';
import '../screens/home_screen.dart';

class Menumain extends StatefulWidget {
  Color primary1,primary2;
  Menumain(this.primary1, this.primary2);

  @override
  _MenumainState createState() => _MenumainState(primary1,primary2);
}

class _MenumainState extends State<Menumain> {

  Color primary1,primary2;
  _MenumainState(this.primary1, this.primary2);

  double scwidth,scheight;
  String userName="NEZUKO-CHAN";
  String userHomeAddress="SET DATA FROM SERVER";
  double sidebarIconSize=25.0 ;
  double sidebarTextSize=16.0 ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 90.0,bottom: 40.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.kolpaper.com/wp-content/uploads/2020/06/Nezuko-Kamado-Wallpapers.jpg"),
                          radius: 50.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0,top: 10.0),
                        child: Text(userName,
                          style: TextStyle(color: primary1,fontSize: 13.0),
                          textAlign: TextAlign.left,),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0,top: 10.0),
                        child: Text(userHomeAddress,
                          style: TextStyle(color: primary1,fontSize: 13.0),
                          textAlign: TextAlign.left,),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  MenuButton( iconsize: 20,label: "HOME",icon: Icons.home,primary: primary1,function: ()
                  {
                        Navigator.pushNamed(context, '/home');
                  },),
                  MenuButton( iconsize: 20,label: "PROFILE",icon: Icons.account_circle,primary: primary1,function: ()
                  {
                    Navigator.pushNamed(context, "/profile");
                  },),
                  MenuButton( iconsize: 20,label: "MY OFFERS",icon: Icons.local_offer,primary: primary1,function: ()
                  {

                  },),
                  MenuButton( iconsize: 20,label: "HISTORY",icon: Icons.history,primary: primary1,function: ()
                  {

                  },),
                  MenuButton( iconsize: 20,label: "SELL",icon: Icons.dashboard,primary: primary1,function: ()
                    {

                    },),
                  MenuButton( iconsize: 20,label: "SETTING",icon: Icons.settings,primary: primary1,function: ()
                  {

                  },),
                  MenuButton( iconsize: 20,label: "CONTACT US",icon: Icons.contact_mail,primary: primary1,function: ()
                  {

                  },),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120.0,bottom: 5.0,left: 16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton.icon(
                  color: Colors.transparent,
                  icon: Icon(Icons.exit_to_app,color: primary1,size: sidebarIconSize,),
                  label: Text("LOGOUT"
                      ,style: TextStyle(color: primary1,fontSize:sidebarTextSize)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () { },
                ),
              ),
            )
          ],),
      ),
    );
  }
}
