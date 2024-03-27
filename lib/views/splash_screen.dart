// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/constants.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/utils/instances.dart';
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

  bool upDown = true;

  @override
  void initState() {
    nextPage();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: primaryColor,
      body: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, -1.0),
          end: Offset(0.0, 0.0),
        ).animate(animationController),
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Image.asset(
         
            'assets/images/splash.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
          
    );
  }
}
