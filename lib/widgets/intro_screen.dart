// // ignore_for_file: must_be_immutable, use_build_context_synchronously

// import 'package:smartech/main.dart';
// import 'package:smartech/screens/webview.dart';
// import 'package:smartech/utils/colors.dart';
// import 'package:smartech/utils/constants.dart';
// import 'package:smartech/utils/instances.dart';
// import 'package:smartech/widgets/major_button.dart';
// import 'package:smartech/widgets/spacing.dart';
// import 'package:smartech/widgets/text.dart';
// import 'package:hive/hive.dart';

// class IntroPageIntems extends StatefulWidget {
//   IntroPageIntems(
//       {required this.imagePath,
//       required this.controller,
//       required this.currenIndedx,
//       required this.title,
//       required this.subtitle,
//       Key? key})
//       : super(key: key);
//   String title, subtitle;
//   String imagePath;
//   PageController controller;
//   int currenIndedx;

//   @override
//   State<IntroPageIntems> createState() => _IntroPageIntemsState();
// }

// class _IntroPageIntemsState extends State<IntroPageIntems> {
//   @override
//   void initState() {
//     determineUser();
//     super.initState();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Container(
//       decoration: BoxDecoration(color: fadeedBackground),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//               flex: 5,
//               child: Column(
//                 children: [
//                   SafeArea(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         YMargin(MediaQuery.of(context).size.height * 0.05),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: widget.currenIndedx == 3
//                               ? Container()
//                               : GestureDetector(
//                                   onTap: () {
//                                     widget.controller.animateToPage(3,
//                                         duration:
//                                             const Duration(milliseconds: 800),
//                                         curve: Curves.easeOutCirc);
//                                   },
//                                   child: TextOf(
//                                       text: 'Skip',
//                                       size: 19,
//                                       weight: FontWeight.w600,
//                                       color: primaryColor),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   YMargin(MediaQuery.of(context).size.height * 0.1),
//                   SizedBox(
//                       child: Image.asset(
//                     widget.imagePath,
//                     height: 300,
//                   )),
//                 ],
//               )),
//           Expanded(
//               flex: 4,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 decoration: BoxDecoration(
//                     color: white,
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20))),
//                 child: Column(
//                   children: [
//                     Expanded(
//                         flex: 5,
//                         child: Column(
//                           children: [
//                             const YMargin(36),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 pageIndicator(0, widget.currenIndedx),
//                                 const XMargin(10),
//                                 pageIndicator(1, widget.currenIndedx),
//                                 const XMargin(10),
//                                 pageIndicator(2, widget.currenIndedx),
//                                 const XMargin(10),
//                                 pageIndicator(3, widget.currenIndedx),
//                               ],
//                             ),
//                             const YMargin(16),
//                             TextOf(
//                                 text: widget.title,
//                                 size: 16,
//                                 weight: FontWeight.w500,
//                                 align: TextAlign.center,
//                                 color: black),
//                             const YMargin(10),
//                             TextOf(
//                               text: widget.subtitle,
//                               size: 12,
//                               weight: FontWeight.w500,
//                               color: black,
//                               align: TextAlign.center,
//                               height: 2,
//                             ),
//                             const YMargin(30)
//                           ],
//                         )),
//                     Expanded(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             widget.currenIndedx == 3
//                                 ? MajorButton(
//                                     text: "Let's Get started",
//                                     onTap: () {
//                                       setUser();
//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const ViewWebPage()),
//                                           (route) => false);
//                                     },
//                                     enabled: true)
//                                 : MajorButton(
//                                     text: 'Continue',
//                                     onTap: () {
//                                       widget.controller.animateToPage(
//                                           widget.currenIndedx + 1,
//                                           duration:
//                                               const Duration(milliseconds: 800),
//                                           curve: Curves.easeOutCirc);
//                                     },
//                                     enabled: true),
//                             const YMargin(15)
//                           ],
//                         ))
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   smallBtn(context, String text, Color? textColor, Color? btnColor,
//       VoidCallback action) {
//     return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             backgroundColor: btnColor ?? primaryColor,
//             fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45)),
//         onPressed: () {},
//         child: TextOf(
//             text: text,
//             size: 15,
//             weight: FontWeight.w500,
//             color: textColor ?? white));
//   }

//   pageIndicator(int thisItemIndex, int currentIndex) {
//     return SizedBox(
//       height: 10,
//       width: 10,
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: thisItemIndex == widget.currenIndedx
//                 ? primaryColor
//                 : Colors.indigo.shade100),
//       ),
//     );
//   }

//   // void setUser() async {
//   //   var openBox = await Hive.openBox(USER_BOX);
//   //   openBox.put(REGISTERED_USER_KEY, true);
//   // }
// }

// ss(BuildContext context, String text, Color? textColor, Color? btnColor,
//     VoidCallback action) {
//   return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           backgroundColor: btnColor ?? primaryColor,
//           fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45)),
//       onPressed: () {},
//       child: TextOf(
//           text: text,
//           size: 15,
//           weight: FontWeight.w500,
//           color: textColor ?? white));
// }
