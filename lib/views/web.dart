// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/views/error_page.dart';
import 'package:niteon/views/loading_page.dart';
import 'package:niteon/widgets/spacing.dart';
import 'package:niteon/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late ContextMenu contextMenu;
  bool firstTime = true;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        // useOnDownloadStart: true,
        useOnLoadResource: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        transparentBackground: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        supportMultipleWindows: true,
        disableDefaultErrorPage: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool pageIsLoaded = false;
  double progress = 0;
  late PullToRefreshController pullToRefreshController;
  String siteUrl = "https://niteon.co";
  String url = "";
  String downloadUrl = "";
  bool userCanGoBack = false;
  bool userCanGoForward = false;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  ConnectivityResult _connectionResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  List<BottomNavItem> navOptionList = [
    BottomNavItem(
        index: 0,
        navName: "Home",
        iconPath: ImageOf.homeIcon,
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
        navName: "My Account",
        iconPath: ImageOf.myAccountIcon,
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

  @override
  void initState() {
    contextMenu = ContextMenu(
      menuItems: [
        ContextMenuItem(
            androidId: 1,
            iosId: "1",
            title: "Special",
            action: () async {
              print("Menu item Special clicked!");
              print(await webViewController?.getSelectedText());
              await webViewController?.clearFocus();
            })
      ],
      onHideContextMenu: () {
        print("onHideContextMenu");
      },
      onContextMenuActionItemClicked: (contextMenuItemClicked) async {
        var id = contextMenuItemClicked.androidId;
        print("onContextMenuActionItemClicked: " +
            id.toString() +
            " " +
            contextMenuItemClicked.title);
      },
      options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
      onCreateContextMenu: (hitTestResult) async {
        print("onCreateContextMenu");
        print(hitTestResult.extra);
        print(await webViewController?.getSelectedText());
      },
    );
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    firstTime == true ? siteUrl : () {};
    firstTime = false;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  Future loadPage() async {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        pageIsLoaded = true;
      });
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionResult = result;
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 10), () {
    //   BotToast.cleanAll();
    // });
    return (_connectionResult == ConnectivityResult.mobile ||
            _connectionResult == ConnectivityResult.wifi)
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (downloadProgress > 0 && downloadProgress < 100)
                        LinearProgressIndicator(
                          value: downloadProgress / 100,
                          color: primaryColor,
                        ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          InAppWebView(
                            key: webViewKey,
                            initialUrlRequest:
                                URLRequest(url: Uri.parse(siteUrl)),
                            initialOptions: options,
                            initialUserScripts:
                                UnmodifiableListView<UserScript>([]),
                            contextMenu: contextMenu,
                            pullToRefreshController: pullToRefreshController,
                            onWebViewCreated:
                                (InAppWebViewController controller) async {
                              webViewController = controller;
                              setState(() {});
                            },
                            onLoadStart: (controller, url) {
                              setState(() {
                                this.url = url.toString();
                              });
                              loader();
                            },
                            androidOnPermissionRequest:
                                (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action:
                                      PermissionRequestResponseAction.GRANT);
                            },
                            shouldOverrideUrlLoading:
                                (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;

                              if (![
                                "http",
                                "https",
                                "file",
                                "chrome",
                                "data",
                                "javascript",
                                "about"
                              ].contains(uri.scheme)) {
                                // ignore: deprecated_member_use
                                if (await canLaunch(url)) {
                                  // ignore: deprecated_member_use
                                  await launch(
                                    url,
                                  );
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStop: (controller, url) async {
                              BotToast.cleanAll();
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                this.url = url.toString();
                              });
                            },
                            onLoadError: (controller, url, code, message) {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                progress = 0.0;
                              });
                            },
                            onProgressChanged: (controller, progress) {
                              if (progress == 1.0) {
                                pullToRefreshController.endRefreshing();
                              }
                              setState(() {
                                this.progress = progress.toDouble();
                              });
                            },
                            onUpdateVisitedHistory:
                                (controller, url, androidIsReload) {
                              setState(() {
                                this.url = url.toString();
                                // urlController.text = this.url;
                              });
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              print(consoleMessage);
                            },
                          ),
                        ],
                      ),
                      progress < 1.0 ? LoadingPage() : Container(),
                    ],
                  ),
                )
              ]),
            ),
            bottomNavigationBar: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: white),
              height: 70,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: navOptionList
                    .map((BottomNavItem e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          loader();
                          setState(() {
                            currentIndex = e.index;
                            // siteUrl = urlLinks[currentIndex];
                          });
                          await webViewController?.loadUrl(
                              urlRequest: URLRequest(url: Uri.parse(e.url)));
                        },
                        child: Container(
                          width: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageIcon(
                                AssetImage(e.iconPath),
                                color: currentIndex == e.index
                                    ? black
                                    : Colors.grey.shade500,
                              ),
                              const YMargin(7),
                              TextOf(
                                e.navName,
                                8,
                                currentIndex == e.index
                                    ? black
                                    : Colors.grey.shade500,
                                FontWeight.w400,
                              )
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                              color: currentIndex == e.index
                                  ? Color(0xffF4840C)
                                  : white,
                              borderRadius: BorderRadius.circular(10)),
                        )))
                    .toList(),
              ),
            ),
          )
        : ErrorPage(webViewController: webViewController);
  }

  void loader() {
    BotToast.showWidget(
        toastBuilder: (_) => SizedBox.expand(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: SizedBox.square(
                    dimension: 100,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey.shade200)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

class BottomNavItem {
  BottomNavItem(
      {required this.index,
      required this.navName,
      required this.iconPath,
      required this.url});

  int index;
  String iconPath, navName, url;
}
