
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final Function(String) onItemClick;

  const MenuWidget({Key key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/user_profile.png'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nick',
            style: TextStyle(
                color: Color(0xff00466b),
                fontWeight: FontWeight.w800,
                fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          sliderItem('Home', Icons.home),
          sliderItem('Add Post', Icons.add_circle),
          sliderItem('Notification', Icons.notifications_active),
          sliderItem('Likes', Icons.favorite),
          sliderItem('Setting', Icons.settings),
          sliderItem('LogOut', Icons.arrow_back_ios)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
        TextStyle(color: Color(0xff00466b),),
      ),
      leading: Icon(
        icons,
        color: Color(0xff00466b),
      ),
      onTap: () {
        onItemClick(title);
      });
}