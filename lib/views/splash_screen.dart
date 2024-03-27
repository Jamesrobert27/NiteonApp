// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/constants.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/views/intro_screens.dart';
import 'package:niteon/views/web.dart';

class SplashScreen extends StatefulWidget {
  static const String splashScreen = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  void nextPage() async {
    var openBox = await Hive.openBox(Constants.USER_BOX);
    print(
        'USER RECOGNIZED STATUS IS --------- ${Constants.REGISTERED_USER_KEY}');
    bool recognized = openBox.get(Constants.REGISTERED_USER_KEY) ?? false;
    print(recognized);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context,
          recognized == false ? IntroScreen.introScreen : WebPage.webPage,
          (route) => false);
    });
  }

  late AnimationController animationController;
  late Animation<double> animation;
  bool upDown = true;

  @override
  void initState() {
    //   nextPage();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 180),
    // );

    // _animation = new CurvedAnimation(
    //   parent: _controller,
    //   curve: new Interval(0.0, 1.0, curve: Curves.linear),
    // );
    // _up();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));
    animationController.forward();
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.repeat();
    //   }
    // });
  }

  // void _up() {
  //   setState(() {
  //     if (upDown) {
  //       upDown = false;
  //       _controller.forward(from: 0.0);
  //     } else {
  //       upDown = true;
  //       _controller.reverse(from: 1.0);
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(),
          Transform.translate(
            offset: Offset(0, animation.value),
            child: Image.asset(
              // ImageOf.logo,
              'assets/images/splash.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
          
    );
  }
}
