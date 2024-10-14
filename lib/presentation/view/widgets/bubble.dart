import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formatted_text/formatted_text.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';
import 'package:qubic_ai/presentation/viewmodel/validation/validation_cubit.dart';

import '../../../core/di/get_it.dart';
import '../../../core/utils/constants/colors.dart';

class AiBubble extends StatefulWidget {
  const AiBubble({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  State<AiBubble> createState() => _AiBubbleState();
}

class _AiBubbleState extends State<AiBubble> {
  bool _isShowDateTime = false;
  final _validationCubit = getIt<ValidationCubit>();
  void _showDate() {
    _isShowDateTime = !_isShowDateTime;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDate,
      onDoubleTap: _showDate,
      child: Padding(
        padding: EdgeInsets.only(left: 12.w, top: 7.h, bottom: 7.h),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: context.width / 1.3),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  color: ColorManager.grey.withOpacity(0.1),
                ),
                child: TextSelectionTheme(
                  data: context.theme.textSelectionTheme,
                  child: SelectionArea(
                    child: FormattedText(
                      widget.message,
                      textAlign: TextAlign.start,
                      textDirection:
                          _validationCubit.getTextDirection(widget.message)!,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    "AI",
                    style: context.textTheme.bodySmall,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    opacity: _isShowDateTime ? 1 : 0,
                    child: AnimatedContainer(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 250),
                      height: _isShowDateTime ? 18.h : 0.0,
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        _validationCubit.formatDateTime(widget.time),
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}

class UserBubble extends StatefulWidget {
  const UserBubble({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  bool _isShowDateTime = false;
  final _validationCubit = getIt<ValidationCubit>();
  void _showDate() {
    _isShowDateTime = !_isShowDateTime;
    setState(() {});
  } 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDate,
      onDoubleTap: _showDate,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w, top: 7.h, bottom: 7.h),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: context.width / 1.3),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  color: ColorManager.grey.withOpacity(0.25),
                ),
                child: TextSelectionTheme(
                  data: context.theme.textSelectionTheme,
                  child: SelectionArea(
                    child: FormattedText(widget.message,
                        textDirection:
                            _validationCubit.getTextDirection(widget.message)!,
                        textAlign: TextAlign.start,
                        style: context.textTheme.bodySmall),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    opacity: _isShowDateTime ? 1 : 0,
                    child: AnimatedContainer(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 250),
                      height: _isShowDateTime ? 18.h : 0.0,
                      padding: EdgeInsets.only(right: 16.w),
                      child: Text(
                        _validationCubit.formatDateTime(widget.time),
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Text(
                    "You",
                    style: context.textTheme.bodySmall,
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
