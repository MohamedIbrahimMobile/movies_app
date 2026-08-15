import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;

  final Widget child;

  final Color? backGroundColor;

  final double? radius;

  final Color? sideBorderColor;

  final double? verticalPadding;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backGroundColor,
    this.radius,
    this.sideBorderColor,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? AppColors.transparent,
        padding: EdgeInsetsGeometry.symmetric(vertical: verticalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 15),
          side: BorderSide(
            width: 2,
            color: sideBorderColor ?? AppColors.transparent,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
