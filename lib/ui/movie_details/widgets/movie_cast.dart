import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/cast.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieCast extends StatelessWidget {
  final List<Cast> castList;

  const MovieCast({super.key, required this.castList});

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
          child: Text('cast'.tr(), style: AppStyles.bold24WhiteRoboto),
        ),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: castList.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: context.height * 0.012),
            itemBuilder: (context, index) {
              final cast = castList[index];
              return Container(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: context.width * 0.025,
                  vertical: context.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor,
                  borderRadius: BorderRadius.circular(context.width * 0.03),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width * 0.02),
                      child: cast.urlSmallImage != null
                          ? Image.network(
                              cast.urlSmallImage!,
                              width: context.width * 0.2,
                              height: context.height * 0.09,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.person,
                                    color: AppColors.whiteColor,
                                    size: context.width * 0.1,
                                  ),
                            )
                          : SizedBox(
                              width: context.width * 0.2,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                                size: context.width * 0.14,
                              ),
                            ),
                    ),
                    SizedBox(width: context.width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cast.name!.isEmpty
                                ? 'Name : UnKnow'
                                : 'Name : ${cast.name}',
                            style: AppStyles.reg18WhiteRoboto,
                          ),
                          SizedBox(height: context.height * 0.006),
                          Text(
                            cast.characterName!.isEmpty
                                ? 'Character : UnKnow'
                                : 'Character : ${cast.characterName}',
                            style: AppStyles.reg18WhiteRoboto,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
