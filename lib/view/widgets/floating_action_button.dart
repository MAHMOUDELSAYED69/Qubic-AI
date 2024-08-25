
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton.small(
        shape: const CircleBorder(),
        splashColor: ColorManager.white.withOpacity(0.3),
        elevation: 2,
        onPressed: onPressed,
        backgroundColor: ColorManager.purple,
        child: const Icon(
          Icons.arrow_downward,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
