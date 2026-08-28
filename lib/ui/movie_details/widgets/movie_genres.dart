import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieGenres extends StatelessWidget {
  final List<dynamic>? genres;

  const MovieGenres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (context.width - 32 - (context.width * 0.05)) / 3;
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: context.height * 0.017,
        children: [
          Align(
            alignment: context.locale.languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text('genres'.tr(), style: AppStyles.bold24WhiteRoboto),
          ),

          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: context.width * 0.025,
                runSpacing: context.height * 0.012,
                children: genres!.map((genre) {
                  return Container(
                    width: itemWidth,
                    padding: EdgeInsets.symmetric(
                      vertical: context.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkGrayColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        genre.toString(),
                        style: AppStyles.reg16WhiteRoboto,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
