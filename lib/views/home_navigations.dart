// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:niteon/utils/colors.dart';
// import 'package:niteon/utils/images.dart';
// import 'package:niteon/views/web_cart.dart';
// import 'package:niteon/views/web_home.dart';
// import 'package:niteon/views/web_my_account.dart';
// import 'package:niteon/views/web_shop.dart';
// import 'package:niteon/widgets/spacing.dart';
// import 'package:niteon/widgets/text.dart';

// class HomeNavigationScreen extends StatefulWidget {
//   static const String homeNavigationScreen = "homeNavigationScreen";
//   const HomeNavigationScreen({super.key});

//   @override
//   State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
// }

// class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
//   int currentIndex = 0;
//   List urls = [
//     // TabOne(),
//     // TabTwo(),
//     // TabOne(),
//     // TabTwo(),
//     WebPageHome(siteUrl: "https://facebook.com"),
//     WebPageCart(siteUrl: "https://www.youtube.com/watch?v=LHzIWZPGBpE"),
//     WebPageMyAccount(siteUrl: "https://twitter.com"),
//     WebPageShop(siteUrl: "https://google.com")
//   ];
//   List<BottomNavItem> navOptionList = [
//     BottomNavItem(index: 0, navName: "Home", iconPath: ImageOf.homeIcon),
//     BottomNavItem(index: 1, navName: "Shop", iconPath: ImageOf.shopIcon),
//     BottomNavItem(index: 2, navName: "Cart", iconPath: ImageOf.cartIcon),
//     BottomNavItem(
//         index: 3, navName: "My Account", iconPath: ImageOf.myAccountIcon),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         return Scaffold(
//           body: urls[currentIndex],
//           bottomNavigationBar: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(color: white),
//             height: 70,
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: navOptionList
//                   .map((BottomNavItem e) => InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () {
//                         setState(() {
//                           currentIndex = e.index;
//                         });
//                         print(currentIndex);
//                         // ref
//                         //     .watch(webProvider.notifier)
//                         //     .setWebPage(webPage: urls.elementAt(currentIndex));
//                         print(urls.indexOf(urls.elementAt(currentIndex)));
//                         // print(urls.elementAt(currentIndex));
//                         //  WebPage.webViewController?.reload();
//                         //    Navigator.pushNamedAndRemoveUntil(context, urls.elementAt(currentIndex), (route) => false)
//                       },
//                       child: Container(
//                         width: 65,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ImageIcon(
//                               AssetImage(e.iconPath),
//                               color: currentIndex == e.index
//                                   ? black
//                                   : Colors.grey.shade500,
//                             ),
//                             const YMargin(7),
//                             TextOf(
//                               e.navName,
//                               8,
//                               currentIndex == e.index
//                                   ? black
//                                   : Colors.grey.shade500,
//                               FontWeight.w400,
//                             )
//                           ],
//                         ),
//                         margin: EdgeInsets.symmetric(vertical: 5),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                         decoration: BoxDecoration(
//                             color:
//                                 currentIndex == e.index ? primaryColor : white,
//                             borderRadius: BorderRadius.circular(10)),
//                       )))
//                   .toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BottomNavItem {
//   int index;
//   String iconPath, navName;
//   BottomNavItem(
//       {required this.index, required this.navName, required this.iconPath});
// }

// // class WebNotifier extends StateNotifier<WebPage> {
// //   WebNotifier() : super(WebPage(siteUrl: "https://google.com"));

// //   void setWebPage({required WebPage webPage}) {
// //     state = webPage;
// //   }
// // }

// // class TodosNotifier extends StateNotifier<List<Todo>> {
// //   // We initialize the list of todos to an empty list
// //   TodosNotifier(): super([]);

// // class TabOne extends StatelessWidget {
// //   const TabOne({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return WebPage(siteUrl: "https://google.com");
// //   }
// // }

// // class TabTwo extends StatelessWidget {
// //   const TabTwo({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return WebPage(siteUrl: "https://twitter.com");
// //   }
// // }
