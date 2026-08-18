import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class LanguageToggleSwitch extends StatefulWidget {
  const LanguageToggleSwitch({super.key});

  @override
  State<LanguageToggleSwitch> createState() => _LanguageToggleSwitchState();
}

class _LanguageToggleSwitchState extends State<LanguageToggleSwitch> {
  final List<String> flagAssets = [AppAssets.arIcon, AppAssets.enIcon];

  @override
  Widget build(BuildContext context) {
    int currentValue = context.locale.languageCode == 'ar' ? 0 : 1;

    return UnconstrainedBox(
      child: AnimatedToggleSwitch<int>.rolling(
        current: currentValue,
        values: [0, 1],
        onChanged: (index) async {
          if (index == 0) {
            await context.setLocale(Locale('ar'));
          } else {
            await context.setLocale(Locale('en'));
          }
          setState(() {});
        },
        iconBuilder: (value, foreground) {
          bool isEgyptSelected = (value == 0 && currentValue == 0);

          return ClipOval(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: isEgyptSelected
                    ? [
                        BoxShadow(
                          color: AppColors.yellowColor,
                          blurRadius: 9,
                          spreadRadius: 3,
                        ),
                      ]
                    : [],
              ),
              child: Image.asset(
                flagAssets[value],
                width: context.width * 0.08,
                height: context.width * 0.08,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        style: ToggleStyle(
          backgroundColor: AppColors.transparent,
          borderColor: AppColors.yellowColor,
          indicatorColor: AppColors.yellowColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        height: context.height * 0.05,
        spacing: context.width * 0.02,
      ),
    );
  }
}
