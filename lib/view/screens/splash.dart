import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/utils/constants/colors.dart';
import 'package:qubic_ai/utils/constants/routes.dart';
import 'package:qubic_ai/utils/extentions/extentions.dart';

import '../../utils/constants/images.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
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
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Qubic AI",
                    speed: const Duration(milliseconds: 500),
                    textStyle: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 30.0.sp,
                    ),
                    colors: ColorManager.colorizeColors,
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
