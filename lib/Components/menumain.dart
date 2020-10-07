import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/dashboard.dart';

class Menumain extends StatefulWidget {
  bool menuiscolapsed=true;
  @override
  _MenumainState createState() => _MenumainState();
}

class _MenumainState extends State<Menumain> {
  bool menuiscolapsed=Menumain().menuiscolapsed;
  double scwidth,scheight;
  String userName="NEZUKO-CHAN";
  String userHomeAddress="SET DATA FROM SERVER";
  Color sidebarBakgrndclr=Colors.deepPurple[700];
  Color sidebarTextIconsclr=Colors.white;
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
              padding: const EdgeInsets.only(top: 100.0,bottom: 40.0),
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
                          style: TextStyle(color: sidebarTextIconsclr,fontSize: 13.0),
                          textAlign: TextAlign.left,),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0,top: 10.0),
                        child: Text(userHomeAddress,
                          style: TextStyle(color: sidebarTextIconsclr,fontSize: 13.0),
                          textAlign: TextAlign.left,),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: sidebarBakgrndclr,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.account_circle,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("PROFILE"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(

                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.history,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("History"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.local_offer,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("My Offers"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.dashboard,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("Sell"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.settings,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("Settings"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      color: sidebarBakgrndclr,
                      icon: Icon(Icons.contact_phone,color: sidebarTextIconsclr,size: sidebarIconSize,),
                      label: Text("Contact us"
                          ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),),
                      onPressed: () {  },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120.0,bottom: 5.0,left: 16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton.icon(
                  color: sidebarBakgrndclr,
                  icon: Icon(Icons.exit_to_app,color: sidebarTextIconsclr,size: sidebarIconSize,),
                  label: Text("Log out"
                      ,style: TextStyle(color: sidebarTextIconsclr,fontSize:sidebarTextSize)),
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
