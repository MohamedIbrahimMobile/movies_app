import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? radius;
  final double? verticalPadding;
  final Color? backgroundColor;
  final Color? sideColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.radius,
    this.sideColor,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.transparent,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 15),
          side: BorderSide(width: 2, color: sideColor ?? AppColors.transparent),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
