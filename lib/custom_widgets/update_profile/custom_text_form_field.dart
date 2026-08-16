import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final String icon;

  const CustomTextFormField({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.reg20WhiteRoboto,
      decoration: InputDecoration(
        hintText: text.tr(),
        hintStyle: AppStyles.reg20WhiteRoboto,
        contentPadding: EdgeInsets.symmetric(vertical: context.height * 0.017),
        prefixIcon: Container(
          margin: EdgeInsetsDirectional.only(
            start: context.width * 0.05,
            end: context.width * 0.025,
          ),
          child: Image.asset(icon, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
