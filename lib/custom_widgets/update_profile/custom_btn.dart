import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isBorder;
  final Color background;
  final TextStyle textStyle;

  const CustomBtn({
    super.key,
    required this.text,
    required this.textStyle,
    required this.background,
    required this.onTap,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isBorder ? AppColors.transparent : background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 1,
            color: isBorder ? AppColors.yellowColor : AppColors.transparent,
          ),
        ),
        minimumSize: Size(double.infinity, context.height * 0.066),
      ),
      child: Text(text.tr(), style: textStyle),
    );
  }
}
