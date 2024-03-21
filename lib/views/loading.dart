// import 'package:SimplePay/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:niteon/utils/colors.dart';

void showLoader() {
  // authRepo.isDialogShowing = true;
  Get.dialog(
    barrierColor: Colors.black.withOpacity(.8),
    barrierDismissible: false,
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 130,
          width: 130,
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotateMultiple,
            colors: [Colors.white],
            strokeWidth: 2,
            pathBackgroundColor:
                //  showPathBackground ?
                Colors.black45,
            // : null,
          ),
        ),
      ],
    ),
  );
}

void linearLoader() {
  // authRepo.isDialogShowing = true;
  Get.dialog(
    barrierColor: Colors.black.withOpacity(.8),
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(white),
        ),
      ],
    ),
  );
}

// Hide Loader
void hideLoader() {
  // authRepo.isDialogShowing = false;
  // Navigator.of(context).pop();
  Get.back();
}

class OverlayLoader extends StatelessWidget {
  final Scaffold child;
  final bool isLoading;
  const OverlayLoader({
    super.key,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          child,
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.9),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
