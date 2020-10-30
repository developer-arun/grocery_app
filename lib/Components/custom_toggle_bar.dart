import 'package:flutter/material.dart';
import 'package:grocery_app/utilities/constants.dart';


class CustomToggleBar extends StatefulWidget {
  @override
  _CustomToggleBarState createState() => _CustomToggleBarState();

  final int selectedTab;
  final Function onTabChanged;
  final String tab1Name,tab2Name;
  const CustomToggleBar({@required this.selectedTab,@required this.tab1Name,@required this.tab2Name,@required this.onTabChanged});
}

class _CustomToggleBarState extends State<CustomToggleBar> {

  int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: kColorPurple.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedTab = 0;
                });
                widget.onTabChanged(selectedTab);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == 0 ? kColorPurple : kColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    widget.tab1Name,
                    style: TextStyle(
                      color: selectedTab == 0 ? kColorWhite : kColorPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedTab = 1;
                });
                widget.onTabChanged(selectedTab);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == 1 ? kColorPurple : kColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    widget.tab2Name,
                    style: TextStyle(
                      color: selectedTab == 1 ? kColorWhite : kColorPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
