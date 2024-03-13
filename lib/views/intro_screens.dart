// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    setState(() {
      _pageController = PageController();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageBackground(
        body: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (int value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextOf(
                      currentIndex == 0
                          ? "Welcome to\nNITEON"
                          : currentIndex == 1
                              ? "No 1. B2B African\nMarketplace"
                              : "Sell On NITEON",
                      32,
                      white,
                      FontWeight.w600),
                  YMargin(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextOf(
                        currentIndex == 0
                            ? "NITEON is a B2B marketplace focused on connecting emerging African businesses"
                            : currentIndex == 1
                                ? "Seamlessly Connecting continents and cultures for Business growth to the globalized world economy."
                                : "Become a Seller on Niteon, Meet global Demand. Let’s Revolutionize business together",
                        14,
                        white,
                        FontWeight.w300),
                  ),
                  YMargin(30),
                  currentIndex < 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: currentIndex == index
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.3)),
                            );
                          }))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
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
                          },
                          child: TextOf(
                              "Explore Now", 20, black, FontWeight.w700)),
                  YMargin(currentIndex < 2 ? 52 : 40),
                ],
              );
            }),
        background: currentIndex == 0
            ? ImageOf.slide1
            : currentIndex == 1
                ? ImageOf.slide2
                : currentIndex == 2
                    ? ImageOf.slide3
                    : "");
  }
}

void setRecognizedUser() async {
  var openBox = await Hive.openBox(Constants.USER_BOX);
  openBox.put(Constants.REGISTERED_USER_KEY, true);
}
