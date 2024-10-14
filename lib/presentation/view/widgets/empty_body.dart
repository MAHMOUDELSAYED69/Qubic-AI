
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';

class EmptyBodyCard extends StatelessWidget {
  const EmptyBodyCard({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 120.w,
            width: 120.w,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(fontSize: 17.sp),
          ),
        ],
      ),
    );
  }
}
