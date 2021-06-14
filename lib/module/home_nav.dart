import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_bus/screens/home.dart';
import 'package:my_bus/screens/profile.dart';

import 'menu_widget.dart';

class HomeNav extends StatefulWidget{
  @override
  HomeNavState createState() =>HomeNavState();
}
class HomeNavState extends State<HomeNav>{
  GlobalKey<SliderMenuContainerState> _key = new GlobalKey<SliderMenuContainerState>();
  int currentPage;
  String title;
  @override
  void initState() {
    super.initState();
    title = "Home";
    currentPage = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
        appBarColor: Colors.white,
        key: _key,
        sliderMenuOpenSize: 300,
        title: Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color: Color(0xff00466b)),
        ),
        sliderMenu: MenuWidget(
          onItemClick: (title) {
            _key.currentState.closeDrawer();
            setState(() {
              this.title = title;
            });
          },
        ),
        sliderMain: _getPage(title),
      ),
    );
  }

  _getPage(String title) {
    switch(title){
      case "Home":
        return Home();
        break;
      case "Add Post":
        return Profile();
        break;
      case "Notification":
        return Home();
        break;
      case "Likes":
        return Home();
        break;
      case "Setting":
        return Home();
        break;
    }
  }

}