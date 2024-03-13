import 'package:flutter/cupertino.dart';
import 'package:niteon/utils/colors.dart';
import 'package:niteon/widgets/spacing.dart';
import 'package:niteon/widgets/text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YMargin(20),
          CupertinoActivityIndicator(
            radius: 25,
            color: primaryColor,
          ),
          YMargin(10),
          TextOf("Please wait...", 12, black, FontWeight.w500)
        ],
      ),
    ));
  }
}
