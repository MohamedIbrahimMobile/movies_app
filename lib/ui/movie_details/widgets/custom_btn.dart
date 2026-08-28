import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomBtn extends StatelessWidget {
  final bool isPlay;
  final VoidCallback onTap;
  final Widget child;

  const CustomBtn({
    super.key,
    required this.isPlay,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width * 0.13,
        height: context.height * 0.06,
        decoration: BoxDecoration(
          color: isPlay
              ? AppColors.whiteColor.withValues(alpha: 0.1)
              : AppColors.blackColor.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
