import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale.languageCode == 'ar';
    bool isEn = context.locale.languageCode == 'en';

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Container(
        height: context.height * 0.044,
        width: context.width * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: context.width * 0.005,
            color: AppColors.yellowColor,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: isEn ? -context.width * 0.005 : 0,
              child: GestureDetector(
                onTap: () {
                  context.setLocale(Locale('en'));
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: isAr
                      ? EdgeInsets.only(left: context.width * 0.01)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isEn
                        ? Border.all(
                            width: context.width * 0.0126,
                            color: AppColors.yellowColor,
                          )
                        : Border(),
                  ),
                  child: Image.asset(
                    AppAssets.enIcon,
                    width: context.width * 0.065,
                    height: context.height * 0.04,
                  ),
                ),
              ),
            ),
            Positioned(
              right: isAr ? -context.width * 0.005 : 0,
              child: GestureDetector(
                onTap: () {
                  context.setLocale(Locale('ar'));
                },
                child: Container(
                  padding: isEn
                      ? EdgeInsets.only(right: context.width * 0.012)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isAr
                        ? Border.all(
                            width: context.width * 0.0126,
                            color: AppColors.yellowColor,
                          )
                        : Border(),
                  ),
                  child: Image.asset(
                    AppAssets.arIcon,
                    width: context.width * 0.065,
                    height: context.height * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
