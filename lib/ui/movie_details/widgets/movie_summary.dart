import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Text(summary, style: AppStyles.reg16WhiteRoboto),
        ),
      ],
    );
  }
}
