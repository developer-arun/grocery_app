import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  final Widget leadingWidget;
  const SettingsPage({@required this.leadingWidget});
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kColorPurple,
        ),
        backgroundColor: kColorWhite,
        elevation: 0,
        leading: widget.leadingWidget,
        centerTitle: true,
        title: Text(
          'My Setting',
          style: TextStyle(
            color: kColorPurple,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Settings Page',
        ),
      ),
    );
  }
}
