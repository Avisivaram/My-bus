import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_bus/module/menu_widget.dart';
import 'package:my_bus/screens/map.dart';
import 'package:my_bus/screens/scanner.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentPage =0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Color(0xff00466b),
        onTabChangedListener: (int position) {
          setState(() {
            currentPage =position;
          });
        },
        inactiveIconColor: Color(0xff00466b),
        key: bottomNavigationKey,
        tabs: [
          TabData(iconData: Icons.add_location, title: "Map"),
          TabData(iconData: Icons.qr_code_scanner, title: "Scanner"),
        ],

      ),
    );
  }

  _getPage(int page) {
    switch(page){
      case 0:
        return Map();
        break;
      case 1:
        return Scanner();
        break;
    }
  }
}