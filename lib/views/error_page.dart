import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/utils/images.dart';
import 'package:niteon/widgets/spacing.dart';
import 'package:niteon/widgets/text.dart';
import 'package:webview_flutter/webview_flutter.dart';

@immutable
class ErrorPage extends StatefulWidget {
  ErrorPage({
    Key? key,
    required this.webViewController,
  }) : super(key: key);
  WebViewController? webViewController;
  @override
  _ErrorPageState createState() => _ErrorPageState();
}


class _ErrorPageState extends State<ErrorPage> {
  double _width = 400.0;
  double _height = 50.0;

  void _tapDown(TapDownDetails details) {
    setState(() {
      _width = 300.0;
      _height = 36.0;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      _width = 400.0;
      _height = 50.0;
    });
  }

  void _tapCancel() {
    setState(() {
      _width = 400;
      _height = 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Image.asset(
                        ImageOf.network,
                        height: 250,
                      ),
                      YMargin(
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextOf('Something went wrong', 15, black, FontWeight.w600,
                          align: TextAlign.center),
                      YMargin(2),
                      TextOf(
                          'Kindly confirm your internet connection\nis stable and try again.',
                          13,
                          Colors.grey,
                          FontWeight.w500,
                          align: TextAlign.center),
                      YMargin(
                        MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTapDown: _tapDown,
                        onTapUp: _tapUp,
                        onTapCancel: _tapCancel,
                        onTap: () {
                          widget.webViewController?.reload();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: _width,
                          height: _height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primaryColor,
                          ),
                          child: Center(
                            child: TextOf('Reload', 15, white, FontWeight.w500),
                          ),
                        ),
                      ),
                    ])))));
  }
}
