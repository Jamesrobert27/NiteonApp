// import 'package:SimplePay/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:niteon/utils/colors.dart';

void showLoader() {
  Get.dialog(
    barrierColor: Colors.white,
    barrierDismissible: false,
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [InfiniteAnimation()],
    ),
  );
}

// Hide Loader
void hideLoader() {
  Get.back();
}

class InfiniteAnimation extends StatefulWidget {
  InfiniteAnimation();

  @override
  _InfiniteAnimationState createState() => _InfiniteAnimationState();
}

class _InfiniteAnimationState extends State<InfiniteAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 6.34,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));
    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => 
      Transform.rotate(
        angle: animation.value,
        // scaleX: animation.value / 3,
        // scaleY: animation.value / 3,
        child: Image.asset(
          'assets/images/app_icon.png',
          height: 80,
          width: 80,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
