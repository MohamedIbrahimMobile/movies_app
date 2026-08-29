import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSummary extends StatelessWidget {
  final String description;

  const MovieSummary({super.key, required this.description});

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
          child: Text('Description'.tr(), style: AppStyles.bold24WhiteRoboto),
        ),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Text(description, style: AppStyles.reg16WhiteRoboto),
        ),
      ],
    );
  }
}
