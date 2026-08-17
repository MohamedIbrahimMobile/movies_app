import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({super.key});

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  int value = 0;
  final List<String> flagAssets = [
    AppAssets.enIcon,
    AppAssets.arIcon
  ];
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: AnimatedToggleSwitch<int>.rolling(
        current: value,
        values: [0, 1],
        onChanged: (i) async {
          setState(() => value = i);

          if (i == 0) {
            await context.setLocale(const Locale('en'));
          } else {
            await context.setLocale(const Locale('ar'));
          }
        },

        iconBuilder: (value, foreground) {
          return ClipOval(
            child: Image.asset(
              flagAssets[value],
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          );

        },
        style: ToggleStyle(
          backgroundColor: AppColors.transparent,
          borderColor: AppColors.yellowColor,
          indicatorColor: AppColors.yellowColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: context.height*0.05,
        spacing: 20,
      ),
    );
  }
}
