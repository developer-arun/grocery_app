import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  IconData icon;
  String label;
  Color primary;
  double iconsize;
  Function function;
  MenuButton({this.icon,this.label,this.iconsize,this.primary,this.function});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
        color: Colors.transparent,
        icon: Icon(icon,color: primary,size: iconsize,),
        label: Text(label
            ,style: TextStyle(color: primary,fontSize:iconsize)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),),
        onPressed: () {
          function();
          },
      ),
    );
  }
}
