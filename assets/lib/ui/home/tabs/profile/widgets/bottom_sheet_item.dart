import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class BottomSheetItem extends StatelessWidget {
  final int currentIndex;
  final List<String> avatarImageList;
  final VoidCallback onTap;
  final int selectedIndex;

  const BottomSheetItem({
    super.key,
    required this.avatarImageList,
    required this.currentIndex,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.height * 0.0086,
          horizontal: context.width * 0.02,
        ),
        decoration: BoxDecoration(
          color: selectedIndex == currentIndex
              ? AppColors.yellowColor.withValues(alpha: 0.5)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.yellowColor, width: 1),
        ),
        child: Image.asset(avatarImageList[currentIndex]),
      ),
    );
  }
}
