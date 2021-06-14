
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class OnBoardingScreenStarter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  int currentPage = 0;
  AnimationController controller;
  Animation<Offset> offset;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Eventbuzz, Let’s shop!",
      "image": "assets/images/splash_1.jpg"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/splash_2.jpg"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.jpg"
    },
  ];
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  void animatedGetStarted(int values) {
    if (values == 2) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
                child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                  child: Text(
                    "skip",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  }),
            )),
            Expanded(
              flex: 9,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                    animatedGetStarted(value);
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SlideTransition(
                  position: offset,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    color: Color(0xff00466b),
                    minWidth: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xff00466b) : Color(0x8000466b),
        borderRadius: BorderRadius.circular(3),
      ), duration: Duration(milliseconds: 200),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "MY BUS",
          style: TextStyle(
            fontSize: 36,
            color: Color(0xff00466b),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 1),
        Image.asset(
          image,
          height: 395,
          width: 295,
        ),
      ],
    );
  }
}
