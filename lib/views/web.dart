// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/views/error_page.dart';
import 'package:niteon/views/loading.dart';
import 'package:niteon/widgets/spacing.dart';
import 'package:niteon/widgets/text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  static const String webPage = "webPage";
  WebPage({
    Key? key,
    this.imageIcon = 'assets/images/individual.png',
  }) : super(key: key);

  String? imageIcon;

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            showLoader();
          },
          onPageFinished: (String url) {
            hideLoader();
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(siteUrl));

    firstTime == true ? siteUrl : () {};
    firstTime = false;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  bool firstTime = true;
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionResult = result;
    });
  }

  bool pageIsLoaded = false;
  double progress = 0;
  String siteUrl = "https://niteon.co";
  String url = "";
  String downloadUrl = "";
  bool userCanGoBack = false;
  bool userCanGoForward = false;
  final GlobalKey webViewKey = GlobalKey();

  ConnectivityResult _connectionResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  List<BottomNavItem> navOptionList = [
    BottomNavItem(
        index: 0,
        navName: "Home",
        // iconPath: ImageOf.homeIcon,
        url: "https://niteon.co"),
    BottomNavItem(
        index: 1,
        navName: "Shop",
        iconPath: ImageOf.shopIcon,
        url: "https://niteon.co/shop"),
    BottomNavItem(
        index: 2,
        navName: "Cart",
        iconPath: ImageOf.cartIcon,
        url: "https://niteon.co/cart"),
    BottomNavItem(
        index: 3,
        navName: "Account",
        // iconPath: ImageOf.myAccountIcon,
        url: "https://niteon.co/auth/login"),
  ];

  @override
  void dispose() {
    _connectivitySubscription!.cancel();
    downloadProgressStream.cancel();
    super.dispose();
  }

  int downloadProgress = 0;
  dynamic downloadId;
  String? downloadStatus;
  late StreamSubscription downloadProgressStream;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if (_connectionResult != ConnectivityResult.mobile ||
    //       _connectionResult != ConnectivityResult.wifi) {
    //     showLoader();
    //   } else {
    //     hideLoader();
    //   }
    // });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        // margin: Edge,
        decoration: BoxDecoration(color: white),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
          top: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navOptionList
              .map((BottomNavItem e) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    showLoader();
                    setState(() {
                      currentIndex = e.index;
                    });
              
                    await controller.loadRequest(Uri.parse(e.url));
                  
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                      e.index == 0
                          ? Icon(
                              Iconsax.home,
                              color: currentIndex == e.index
                                  ? primaryColor
                                  : Colors.grey.shade500,
                            )
                          : e.index == 3
                              ? Icon(
                                  Iconsax.user,
                                  color: currentIndex == e.index
                                      ? primaryColor
                                      : Colors.grey.shade500,
                                )
                              : Image.asset(
                                  e.iconPath!,
                                  height: 25,
                                  width: 25,
                                  color: currentIndex == e.index
                                      ? primaryColor
                                      : Colors.grey.shade500,
                                ),
                      const YMargin(7),
                      TextOf(
                        e.navName,
                        12,
                        currentIndex == e.index
                            ? primaryColor
                            : Colors.grey.shade500,
                        FontWeight.w500,
                      )
                    ],
                  )))
              .toList(),
        ),
      ),
    );
    // : ErrorPage(webViewController: controller);
  }
}

class BottomNavItem {
  BottomNavItem(
      {required this.index,
      required this.navName,
      this.iconPath,
      required this.url});

  int index;
  String? iconPath;
  String navName, url;
}
