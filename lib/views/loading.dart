// import 'package:SimplePay/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:niteon/utils/colors.dart';

void showLoader() {
  // authRepo.isDialogShowing = true;
  Get.dialog(
    barrierColor: const Color.fromARGB(255, 45, 44, 44),
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
  // authRepo.isDialogShowing = false;
  // Navigator.of(context).pop();
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
      //   begin: 0,
      //   end: 12.5664, // 2Radians (360 degrees)
      // ).animate(animationController);
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
    // animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 1),
    // )
    //   ..forward()
    //   ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) =>
          // Transform.rotate(
          //   angle: animation.value,
          //   child:
          CircleAvatar(
        radius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/app_icon.png',
          ),
        ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
