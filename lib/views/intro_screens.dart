// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:niteon/views/home_navigations.dart';
import 'package:niteon/views/web.dart';
import 'package:niteon/widgets/page_background.dart';
import 'package:niteon/widgets/spacing.dart';
import 'package:niteon/widgets/text.dart';

class IntroScreen extends StatefulWidget {
  static const String introScreen = "introScreen";
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
      
  int currentIndex = 0;

  late PageController _pageController;
  late TabController _tabController;
  @override
  void initState() {
    setState(() {
      _pageController = PageController();
      _tabController = TabController(length: 3, vsync: this)
        ..addListener(() {
          setState(() {
            currentIndex = _tabController.index;
          });
        });
    });
    super.initState();
  }

  List<Map> onboard = [
    {
      'text': 'Welcome to\nNITEON',
      'subText':
          'B2B Marketplace connecting African manufacturers to the global Market.',
      'image': ImageOf.slide1,
    },
    {
      'text': 'No 1. B2B African\nMarketplace',
      'subText':
          'Driven by Quality, Innovation, People and Sustainability as the African Trade Center.',
      'image': ImageOf.slide2,
    },
    {
      'text': 'Sell On NITEON',
      'subText':
          'Access Production Credit, Multiple Payment Option, Escrow protection and personalized AI Experience',
      'image': ImageOf.slide3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));
    return Stack(
      alignment: Alignment.center,
      children: [
        TabBarView(controller: _tabController, children: [
          for (var i = 0; i < onboard.length; i++)
            Container(
              padding: EdgeInsets.only(
                  bottom: Get.height * .17, left: 20, right: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, black],
                ),
                image: DecorationImage(
                  image: AssetImage(onboard[i]['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextOf(onboard[i]['text'], 28, white, FontWeight.w600),
                  YMargin(16),
                  TextOf(onboard[i]['subText'], 15, white, FontWeight.w400),
                ],
              ),
            ),
        ]),
        Positioned(
          bottom: 60,
          child: currentIndex == 2
              ? SizedBox(
                  height: 50,
                  width: Get.width * .4,
                  child: ElevatedButton(
                      child: TextOf("Explore Now", 20, black, FontWeight.w500),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                       
                          fixedSize: Size(217, 53),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: primaryColor),
                      onPressed: () {
                        if (currentIndex == 2) {
                          setRecognizedUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, WebPage.webPage, (route) => false);
                        } else {
                          _pageController.animateToPage(currentIndex + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.bounceInOut);
                        }
                      }),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor: currentIndex == index
                                  ? primaryColor
                                  : primaryColor.withOpacity(0.3)));
                    }),
                  ),
                ),
        )
      ],
    );

  }
}

void setRecognizedUser() async {
  var openBox = await Hive.openBox(Constants.USER_BOX);
  openBox.put(Constants.REGISTERED_USER_KEY, true);
}
