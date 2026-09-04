import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSummary extends StatelessWidget {
  final String summary;

  const MovieSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.height * 0.017,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: context.locale.languageCode == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text('summary'.tr(), style: AppStyles.bold24WhiteRoboto),
        ),
        if (summary.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: context.height * 0.025,
              horizontal: context.width * 0.04,
            ),
            decoration: BoxDecoration(
              color: AppColors.darkGrayColor,
              borderRadius: BorderRadius.circular(context.width * 0.03),
            ),
            child: Text(
              'no_information_available'.tr(),
              textAlign: TextAlign.center,
              style: AppStyles.reg16WhiteRoboto,
            ),
          )
        else
          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Text(summary, style: AppStyles.reg16WhiteRoboto),
          ),
      ],
    );
  }
}
