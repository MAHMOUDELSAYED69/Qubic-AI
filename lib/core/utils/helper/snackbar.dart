import 'package:flutter/material.dart';
import 'package:qubic_ai/core/utils/constants/colors.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';

class SnackBarManager {
  static DateTime? _lastSnackBarTime;

  static void snackBar(BuildContext context,
      [String? message, Color? color, int? seconds]) {
    final now = DateTime.now();

    if (_lastSnackBarTime != null &&
        now.difference(_lastSnackBarTime!) < const Duration(seconds: 1)) {
      return;
    }

    _lastSnackBarTime = now;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: AnimationController(
                  duration: const Duration(milliseconds: 300),
                  vsync: Navigator.of(context),
                )..forward(),
                curve: Curves.easeOut,
              ),
            ),
            child: Container(
              color: (color ?? ColorManager.purple).withOpacity(0.85),
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Center(
                  child: Text(
                    message ?? "There was an error, please try again later!",
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(milliseconds: seconds ?? 2500), () {
      overlayEntry.remove();
    });
  }
}
