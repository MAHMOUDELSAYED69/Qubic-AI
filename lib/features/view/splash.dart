import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/core/utils/constants/colors.dart';
import 'package:qubic_ai/core/utils/constants/routes.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';

import '../../core/utils/constants/images.dart';
import '../widgets/animation/colorize_text_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async => Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, RouteManager.home));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImageManager.logo,
              width: 100.w,
              height: 100.w,
            ),
            SizedBox(height: 30.h),
            ColorizeAnimatedText(
              "Qubic AI",
              speed: const Duration(milliseconds: 500),
              textStyle: context.textTheme.bodyLarge!.copyWith(
                fontSize: 30.0.sp,
              ),
              colors: ColorManager.colorizeColors,
            ),
          ],
        ),
      ),
    );
  }
}
